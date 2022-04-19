import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:flutter/material.dart';

class BusItemWidget extends StatelessWidget {
  final Bus bus;

  const BusItemWidget(this.bus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(bus.busNumber,overflow: TextOverflow.clip,),),
      title: Text(bus.busNumber),
      subtitle: Text(bus.status?.text ?? ''),
      isThreeLine: true,
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
