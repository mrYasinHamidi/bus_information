import 'package:animations/animations.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:bus_information/widgets/CustomDropDown.dart';
import 'package:bus_information/widgets/CustomInputField.dart';
import 'package:flutter/material.dart';

class AddDriverForm extends StatefulWidget {
  final Function(Driver)? onSubmit;
  final Duration splashDelay;

  const AddDriverForm({
    Key? key,
    this.onSubmit,
    this.splashDelay = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  State<AddDriverForm> createState() => _AddDriverFormState();
}

class _AddDriverFormState extends State<AddDriverForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;
  final Driver _driver = Driver();
  bool _show = false;


  @override
  void initState() {
    Future.delayed(widget.splashDelay, () {
      setState(() {
        _show = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      reverse: !_show,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
        );
      },
      child: _show
          ? _form
          : const SizedBox(),
    );
  }

  Form get _form {
    return Form(
            key: globalKey,
            child: SingleChildScrollView(
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
                      items: ShiftWork.values.asTextList,
                      onChange: _onShiftWorkChange,
                      label: Languages.language.value.shiftWork,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropDown(
                      items: DriverStatus.values.asTextList,
                      label: Languages.language.value.driverStatus,
                      onChange: _onStatusChange,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    onPressed: _onSubmit,
                    child: Text(
                      Languages.language.value.submit,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  String? _personNameValidator(String? value) {
    if (value == null) return '';
    if (value.isEmpty) return Languages.language.value.shouldNotEmpty;
    if (DatabaseHelper.instance.containName(value)) return Languages.language.value.repeatedName;
    return null;
  }

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      DatabaseHelper.instance.put(_driver);
      widget.onSubmit?.call(_driver);
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
