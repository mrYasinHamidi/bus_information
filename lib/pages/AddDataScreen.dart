import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/CustomDropDown.dart';
import 'package:bus_information/widgets/CustomInputField.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;
  final Driver _driver = Driver();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomInputField(
                  label: Languages.language.value.name,
                  validator: _personNameValidator,
                  onChange: _onPersonNameChange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropDown(
                  initializeIndex: 0,
                  items: ShiftWork.values.asTextList,
                  onChange: _onShiftWorkChange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropDown(
                  initializeIndex: 0,
                  items: DriverStatus.values.asTextList,
                  onChange: _onStatusChange,
                ),
              ),
              SizedBox(
                width: size.width * .5,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  child: Text(Languages.language.value.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _personNameValidator(String? value) {
    if (value == null) return '';
    if (value.isEmpty) return Languages.language.value.shouldNotEmpty;
    if (DatabaseHelper.instance.containedName(value)) return Languages.language.value.repeatedName;
    return null;
  }

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      DatabaseHelper.instance.put(_driver);
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
  }

  void _onPersonNameChange(String value) {
    _driver.name = value.trim();
  }

  void _onShiftWorkChange(int value) {
    _driver.shiftWork = ShiftWork.values[value];
  }

  void _onStatusChange(int value) {
    _driver.status = DriverStatus.values[value];
  }
}
