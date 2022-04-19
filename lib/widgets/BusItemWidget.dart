import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/widgets/Dot.dart';
import 'package:flutter/material.dart';

class BusItemWidget extends StatelessWidget {
  final Bus bus;

  const BusItemWidget(this.bus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProperty(Languages.language.value.busNumber, bus.busNumber),
              Dot(color: bus.status?.color),
            ],
          ),
          const SizedBox(height: 4),
          _buildProperty(Languages.language.value.busStatus, bus.status?.text??''),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: _decoration(),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.person),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    horizontalTitleGap: 8,
                    minVerticalPadding: 4,
                    title: Text(bus.driverId ?? ''),
                    subtitle: Text(Languages.language.value.driver),
                    dense: true,
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                child: Container(
                  decoration: _decoration(),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 18,
                    ),
                    title: Text(bus.secondDriverId ?? ''),
                    subtitle: Text(Languages.language.value.alternativeDriver),
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    horizontalTitleGap: 8,
                    minVerticalPadding: 4,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 2, offset: Offset(0, 0), spreadRadius: 0, color: Colors.black12)]);
  }

  Row _buildProperty(String name, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(name),
        const Text(' : '),
        Text(value,overflow: TextOverflow.ellipsis,),
      ],
    );
  }
}
