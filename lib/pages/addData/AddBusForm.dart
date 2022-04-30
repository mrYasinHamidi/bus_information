import 'package:animations/animations.dart';
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
  final Function(Bus)? onSubmit;
  final Duration splashDelay;

  const AddBusForm({
    Key? key,
    this.onSubmit,
    this.splashDelay = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  State<AddBusForm> createState() => _AddDriverFormState();
}

class _AddDriverFormState extends State<AddBusForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;
  final Bus _bus = Bus();
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
    return Column(
      children: [
        PageTransitionSwitcher(
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
        ),
      ],
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
                    maxLength: 10,
                    icon: const Icon(Icons.bus_alert),
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
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _onSubmit,
                  // style: ElevatedButton.styleFrom(
                  //   primary: Colors.lightGreen,
                  // ),
                  child: Text(Languages.language.value.submit),
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

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      DatabaseHelper.instance.put(_bus);
      widget.onSubmit?.call(_bus);
    }
  }
}
