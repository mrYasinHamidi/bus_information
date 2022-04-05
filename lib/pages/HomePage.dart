import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/BusItemWidget.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:flutter/material.dart';

import 'addData/AddDataScreen.dart';

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
          title: Text(Languages.language.value.appName),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: Languages.language.value.drivers, icon: const Icon(Icons.person)),
              Tab(text: Languages.language.value.buses, icon: const Icon(Icons.bus_alert)),
            ],
          ),
        ),
        body: TabBarView(children: [
          _buildDriverList(),
          _buildBusList(),
        ]),
        floatingActionButton: FloatingActionButton(onPressed: _onAddClick, child: const Icon(Icons.add)),
      ),
    );
  }

  Widget _buildDriverList() {
    List<Driver> drivers = DatabaseHelper.instance.drivers;
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.instance.driversListenable,
      builder: (context, box, child) {
        if (drivers.isEmpty) {
          return Center(
            child: LottieViewer(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
            ),
          );
        }
        return ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return DriverItemWidget(drivers[index]);
          },
        );
      },
    );
  }

  Widget _buildBusList() {
    List<Bus> buses = DatabaseHelper.instance.buses;
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.instance.busesListenable,
      builder: (context, box, child) {
        if (buses.isEmpty) {
          return Center(
            child: LottieViewer(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
            ),
          );
        }
        return ListView.builder(
          itemCount: buses.length,
          itemBuilder: (context, index) {
            return BusItemWidget(buses[index]);
          },
        );
      },
    );
  }

  void _onAddClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddDataScreen();
        },
      ),
    );
  }
}
