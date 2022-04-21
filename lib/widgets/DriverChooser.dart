import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:flutter/material.dart';

class DriverChooser extends StatefulWidget {
  final List<Driver> drivers;
  final Function(Driver)? onDriverSelect;

  const DriverChooser({Key? key, required this.drivers, this.onDriverSelect}) : super(key: key);

  @override
  State<DriverChooser> createState() => _DriverChooserState();
}

class _DriverChooserState extends State<DriverChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Languages.language.value.drivers),),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon:  Icon(Icons.search),
              ),
            ),
          ),
          if (widget.drivers.isEmpty)
            const Expanded(child: LottieViewer())
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.drivers.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      _onDriverSelect(widget.drivers[index]);
                    },
                    child: DriverItemWidget(widget.drivers[index])),
              ),
            ),
        ],
      ),
    );
  }

  void _onDriverSelect(Driver driver) {
    Navigator.pop(context, driver);
  }
}
