import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';

class BusItemWidget extends StatelessWidget {
  final Bus bus;

  const BusItemWidget(this.bus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(blurRadius: 5, offset: Offset(0, 0), spreadRadius: -1, color: Colors.black38)]),
      child: Column(
        children: [
          Row(
            children: [
              DatabaseHelper.instance.getDriver
            ],
          )
        ],
      ),
    );
  }

  Row _buildProperty(String name, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        SizedBox(
          width: 30,
          child: Text(value),
        ),
      ],
    );
  }
}
