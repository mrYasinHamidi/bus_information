import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Color fillColor;
  final Color borderColor;
  final Color activeBorderColor;
  final double borderWidth;
  final double radius;
  final String? label;
  final Icon icon;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final bool readOnly;
  final String? text;

  const CustomInputField({
    Key? key,
    this.readOnly=false,this.text,
    this.fillColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.radius = 8,
    this.label,
    this.icon = const Icon(Icons.person),
    this.validator,
    this.onChange,
    this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        label: label == null ? null : Text(label ?? ''),
        filled: true,
        fillColor: fillColor.withAlpha(80),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: activeBorderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
      ),
      keyboardType: inputType,
      validator: validator,
      onChanged: onChange,
      readOnly: readOnly,
    );
  }
}
