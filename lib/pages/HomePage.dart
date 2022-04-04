import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/cubits/HomePageBodyCubit.dart';
import 'package:bus_information/models/enums/PageType.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/pages/AddDataScreen.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/BusItemWidget.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).appName),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: Languages.of(context).drivers, icon: const Icon(Icons.person)),
              Tab(text: Languages.of(context).buses, icon: const Icon(Icons.bus_alert)),
            ],
          ),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.instance.init(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return TabBarView(children: [
              _buildListView(PageType.driver),
              _buildListView(PageType.bus),
            ]);
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: _onAddClick, child: const Icon(Icons.add)),
      ),
    );
  }

  Widget _buildListView(PageType type) {
    return ValueListenableBuilder(
      valueListenable: type.listenable,
      builder: (context, box, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            switch (type) {
              case PageType.driver:
                List<Driver> drivers = DatabaseHelper.instance.drivers;
                if (drivers.isNotEmpty) {
                  return DriverItemWidget(drivers[index]);
                }
                break;
              case PageType.bus:
                List<Bus> buses = DatabaseHelper.instance.buses;
                if (buses.isNotEmpty) {
                  return BusItemWidget(buses[index]);
                }
                break;
            }
            return Center(
              child: LottieViewer(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    DatabaseHelper.instance.dispose();
    super.dispose();
  }

  void _onAddClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddDataScreen();
    }));
  }
}
