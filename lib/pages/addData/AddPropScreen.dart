import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/models/objects/Prop.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/BusPreviewr.dart';
import 'package:bus_information/widgets/ItemChooser.dart';
import 'package:bus_information/widgets/DriverPreviewer.dart';
import 'package:flutter/material.dart';

class AddPropScreen extends StatefulWidget {
  const AddPropScreen({Key? key}) : super(key: key);

  @override
  State<AddPropScreen> createState() => _AddPropScreenState();
}

class _AddPropScreenState extends State<AddPropScreen> {
  Driver? _firstDriver;
  Driver? _secondDriver;
  Bus? _bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.language.value.addProp),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DriverPreviewer(
                    driver: _firstDriver,
                    emptyTitle: Languages.language.value.driver,
                    onTap: _selectFirstDriver,
                  ),
                ),
                Expanded(
                  child: DriverPreviewer(
                    driver: _secondDriver,
                    emptyTitle: Languages.language.value.alternativeDriver,
                    onTap: _selectSecondDriver,
                  ),
                ),
              ],
            ),
            BusPreviewer(
              onTap: _selectBus,
              emptyTitle: Languages.language.value.busInformation,
              bus: _bus,
            ),
          ],
        ),
      ),
    );
  }

  void _selectBus() async {
    _bus = await _chooseBus();
    setState(() {});
  }

  void _selectFirstDriver() async {
    _firstDriver = await _chooseDriver();
    setState(() {});
  }

  void _selectSecondDriver() async {
    _secondDriver = await _chooseDriver();
    setState(() {});
  }

  Future<Driver?> _chooseDriver() async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ItemChooser(
          items: DatabaseHelper.instance.drivers,
          type: ObjectType.driver,
        ),
      ),
    );
  }

  Future<Bus?> _chooseBus() async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ItemChooser(
          items: DatabaseHelper.instance.buses,
          type: ObjectType.bus,
        ),
      ),
    );
  }

  void _submit() {
    Prop prop = Prop(
      busId: _bus?.id,
      driverId: _firstDriver?.id,
      secondDriverId: _secondDriver?.id,
    );
    DatabaseHelper.instance.put(prop);
    Navigator.pop(context,true);
  }
}
