import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/pages/addData/AddBusScreen.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/BusItemWidget.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:bus_information/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';

import 'addData/AddDriverScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
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
          floatingActionButton: SafeArea(
            child: ExpandableFab(
              distance: const [60, 120],
              children: [
                ActionButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onPressed: _onPersonAddClick,
                ),
                ActionButton(
                    icon: const Icon(
                      Icons.bus_alert,
                      color: Colors.white,
                    ),
                    onPressed: _onBusAddClick),
              ],
              degrees: const [90, 90],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverList() {
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.instance.driversListenable,
      builder: (context, box, child) {
        List<Driver> drivers = DatabaseHelper.instance.drivers;
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
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.instance.busesListenable,
      builder: (context, box, child) {
        List<Bus> buses = DatabaseHelper.instance.buses;
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

  void _onPersonAddClick() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddDriverScreen();
        },
      ),
    ).then((value) {
      if (value ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(Languages.language.value.operationDone),
            action: SnackBarAction(
              label: Languages.language.value.submit,
              onPressed: () {},
            ),
          ),
        );
      }
    });
  }

  void _onBusAddClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddBusScreen();
        },
      ),
    ).then((value) {
      if (value ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(Languages.language.value.operationDone),
            action: SnackBarAction(
              label: Languages.language.value.submit,
              onPressed: () {},
            ),
          ),
        );
      }
    });
  }
}
