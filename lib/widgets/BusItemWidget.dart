import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/widgets/Dot.dart';
import 'package:flutter/material.dart';

class BusItemWidget extends StatelessWidget {
  final Bus bus;

  const BusItemWidget(this.bus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bus.busNumber),
          Dot(color: bus.status.color),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bus.status.text),
          Text(bus.creationTime.toString()),
        ],
      ),
    );
  }
}
