import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/models/objects/Prop.dart';
import 'package:bus_information/pages/addData/AddBusScreen.dart';
import 'package:bus_information/pages/addData/AddPropScreen.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/BusItemWidget.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:bus_information/widgets/PropItemWidget.dart';
import 'package:bus_information/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';

import 'addData/AddDriverScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Languages.language.value.appName),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: Languages.language.value.props, icon: const Icon(Icons.menu_book)),
                Tab(text: Languages.language.value.drivers, icon: const Icon(Icons.person)),
                Tab(text: Languages.language.value.buses, icon: const Icon(Icons.directions_bus)),
              ],
            ),
          ),
          body: TabBarView(children: [
            _buildItemList(ObjectType.prop),
            _buildItemList(ObjectType.driver),
            _buildItemList(ObjectType.bus),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: _onAddClick,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(ObjectType type) {
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.instance.getListenable(type),
      builder: (context, box, child) {
        List<DatabaseObject> objects = DatabaseHelper.instance.getItems(type);
        if (objects.isEmpty) {
          return Center(
            child: LottieViewer(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
            ),
          );
        }
        return ListView.builder(
          itemCount: objects.length,
          itemBuilder: (context, index) {
            switch (type) {
              case ObjectType.bus:
                return BusItemWidget(objects[index] as Bus);
              case ObjectType.driver:
                return DriverItemWidget(objects[index] as Driver);
              case ObjectType.prop:
                return PropItemWidget(objects[index] as Prop);
            }
          },
        );
      },
    );
  }

  void _onAddClick() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AddPropScreen();
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
