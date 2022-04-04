import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/langueges/En.dart';
import 'package:bus_information/langueges/Fa.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<Widget> items;
  final int? initializeIndex;
  final Color fillColor;
  final Color borderColor;
  final Color activeBorderColor;
  final double borderWidth;
  final double radius;
  final String? label;
  final String? Function(int?)? validator;
  final void Function(int)? onChange;

  const CustomDropDown({
    Key? key,
    this.items = const [],
    this.initializeIndex,
    this.fillColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.radius = 8,
    this.label,
    this.validator,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int? _value;

  @override
  void initState() {
    _setInitValue();
    super.initState();
  }

  void _setInitValue() {
    if (_value != null) return;
    if (widget.items.isEmpty) return;
    if (widget.initializeIndex == null) return;
    if (widget.initializeIndex! >= widget.items.length - 1) {
      _value = widget.items.length - 1;
      return;
    }
    if (widget.initializeIndex! <= 0) {
      _value = 0;
      return;
    }
    _value = widget.initializeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      validator: widget.validator,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        label: widget.label == null ? null : Text(widget.label ?? ''),
        fillColor: widget.fillColor.withAlpha(80),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.activeBorderColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.radius),
            topRight: Radius.circular(widget.radius),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.radius),
            topRight: Radius.circular(widget.radius),
          ),
        ),
      ),
      value: _value,
      items: _buildItems(),
      onChanged: _onSelectValue,
    );
  }

  void _onSelectValue(value) {
    if (value is int) {
      setState(() {
        _value = value;
      });
      widget.onChange?.call(value);
    }
  }

  List<DropdownMenuItem<int>>? _buildItems() {
    return List.generate(
      widget.items.length,
      (index) => DropdownMenuItem<int>(
        value: index,
        child: widget.items.elementAt(index),
      ),
    );
  }
}
