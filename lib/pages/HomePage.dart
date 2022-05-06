import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/models/objects/Prop.dart';
import 'package:bus_information/pages/BusPage.dart';
import 'package:bus_information/pages/DriverPage.dart';
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
  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: _drawer,
          ),
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

  Widget get _drawer => SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue.shade400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                    title: Text('یاسین حمید لکزا'),
                    subtitle: Text('مدیر خط'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: _keyValueText(key: 'سطح دسترسی', value: 'مدیریت'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: _keyValueText(key: 'مسئول مربوطه', value: 'حسن صادقی'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: _keyValueText(key: 'تاریخ ثبت نام', value: '1400/07/15'),
                  ),
                ],
              ),
            ),
            ListTile(leading: const Icon(Icons.settings), title: Text(Languages.language.value.settings)),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const BusPage()));
              },
              leading: const Icon(Icons.person_rounded),
              title: Text(Languages.language.value.drivers),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)..pop()..push(MaterialPageRoute(builder: (BuildContext context) => const DriverPage()));
              },
              leading: const Icon(Icons.directions_bus),
              title: Text(Languages.language.value.buses),
            ),
          ],
        ),
      );

  Row _keyValueText({String key = '', String value = ''}) {
    return Row(
      children: [
        ConstrainedBox(constraints: BoxConstraints(minWidth: size.width * .3), child: Text(key)),
        Text(
          value,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
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
              width: size.width * 0.5,
              height: size.width * 0.5,
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
