import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/pages/addData/AddBusForm.dart';
import 'package:bus_information/pages/addData/AddDriverForm.dart';
import 'package:flutter/material.dart';

class AddButtonDialog extends StatefulWidget {
  final Function(DatabaseObject)? onAddItem;
  final ObjectType type;

  const AddButtonDialog({
    Key? key,
    this.onAddItem,
    this.type = ObjectType.driver,
  }) : super(key: key);

  @override
  State<AddButtonDialog> createState() => _AddButtonDialogState();
}

class _AddButtonDialogState extends State<AddButtonDialog> {
  final Duration _duration = const Duration(milliseconds: 400);

  final Curve _curve = Curves.easeInOutCubicEmphasized;

  Size get size => MediaQuery.of(context).size;

  bool _isOpen = false;

  double get _width => _isOpen ? size.width * 0.5 : 50;

  double get _height => _isOpen ? size.height * .5 : 50;

  Color get _color => _isOpen ? Colors.yellow : Colors.green;

  BorderRadius get _radius => BorderRadius.circular(16);

  BoxDecoration get _decoration => BoxDecoration(color: _color, borderRadius: _radius);

  Widget? get _child {
    if (_isOpen) {
      switch(widget.type){
        case ObjectType.bus:
          return const AddBusForm(
          );
        case ObjectType.driver:
          return AddDriverForm(
            onSubmit: _onSubmit,
            splashDelay: _duration,
          );
        case ObjectType.prop:
          return AddDriverForm(
            onSubmit: _onSubmit,
            splashDelay: _duration,
          );
      }
    }
    return const Icon(
      Icons.add,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isOpen) {
          _close();
          return false;
        }
        return true;
      },
      child: InkWell(
        onTap: _onTap,
        borderRadius: _radius,
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: _decoration,
          curve: _curve,
          duration: _duration,
          child: _child,
        ),
      ),
    );
  }

  void _onTap() {
    if (!_isOpen) {
      _open();
    }
  }

  void _open() {
    setState(() {
      _isOpen = true;
    });
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  _onSubmit(Driver driver) {
    _close();
    widget.onAddItem?.call(driver);
  }
}
