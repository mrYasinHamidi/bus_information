import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/CustomDropDown.dart';
import 'package:bus_information/widgets/CustomInputField.dart';
import 'package:bus_information/widgets/DriverChooser.dart';
import 'package:bus_information/widgets/DriverPreviewer.dart';
import 'package:flutter/material.dart';

class AddBusForm extends StatefulWidget {
  const AddBusForm({Key? key}) : super(key: key);

  @override
  State<AddBusForm> createState() => _AddDriverFormState();
}

class _AddDriverFormState extends State<AddBusForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;
  final Bus _bus = Bus();
  Driver? _driver;
  Driver? _secondDriver;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomInputField(
                maxLength: 10,
                icon: const Icon(Icons.numbers),
                label: Languages.language.value.busNumber,
                validator: _busNumberValidator,
                onChange: _onBusNumberChange,
                inputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropDown(
                label: Languages.language.value.busStatus,
                items: BusStatus.values.asTextList,
                onChange: _onStatusChange,
              ),
            ),
            Row(children: [
              Expanded(
                child: DriverPreviewer(
                  emptyTitle: Languages.language.value.driver,
                  driver: _driver,
                  onTap: _selectFirstDriver,
                ),
              ),
              Expanded(
                child: DriverPreviewer(
                  emptyTitle: Languages.language.value.alternative,
                  driver: _secondDriver,
                  onTap: _selectSecondDriver,
                ),
              ),
            ]),
            const SizedBox(height: 16),
            SizedBox(
              width: size.width * .5,
              child: OutlinedButton(
                onPressed: _onSubmit,
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.lightGreen,
                // ),
                child: Text(Languages.language.value.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _busNumberValidator(String? value) {
    if (value == null) return '';
    if (value.isEmpty) return Languages.language.value.shouldNotEmpty;
    if (DatabaseHelper.instance.containBus(value)) return Languages.language.value.repeatedNumber;
    return null;
  }

  void _onBusNumberChange(String value) {
    _bus.busNumber = value.trim();
  }

  void _onStatusChange(int value) {
    _bus.status = BusStatus.values[value];
  }

  void _selectFirstDriver() async {
    _driver = await _chooseDriver();
    setState(() {});
  }

  void _selectSecondDriver() async {
    _secondDriver = await _chooseDriver();
    setState(() {});
  }

  Future<Driver?> _chooseDriver() async {
    // return await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => ItemChooser(
    //       drivers: DatabaseHelper.instance.drivers,
    //     ),
    //   ),
    // );
  }

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      // _bus.driverId = _driver?.id;
      // _bus.secondDriverId = _secondDriver?.id;
      // DatabaseHelper.instance.put(_bus);
      // Navigator.pop(context,true);
    }
  }
}
