import 'package:bus_information/abstracts/Languages.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            icon: const Icon(Icons.person_add),
            label: Text(Languages.of(context).appName),

          ),
        ),
      ],
    );
  }
}
