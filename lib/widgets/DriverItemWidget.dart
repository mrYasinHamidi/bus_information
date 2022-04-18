import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/widgets/Dot.dart';
import 'package:flutter/material.dart';

class DriverItemWidget extends StatelessWidget {
  final Driver driver;

  const DriverItemWidget(this.driver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(driver.name),
          Dot(color: driver.status.color),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(driver.shiftWork.text),
          Text(driver.status.text),
        ],
      ),
    );
  }
}
