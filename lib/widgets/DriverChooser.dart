import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/widgets/AddButtonDialog.dart';
import 'package:bus_information/widgets/BusItemWidget.dart';
import 'package:bus_information/widgets/DriverItemWidget.dart';
import 'package:bus_information/widgets/LottieViewer.dart';
import 'package:flutter/material.dart';

class ItemChooser extends StatefulWidget {
  final List<DatabaseObject> items;
  final ObjectType type;

  const ItemChooser({
    Key? key,
    required this.items,
    this.type = ObjectType.driver,
  }) : super(key: key);

  @override
  State<ItemChooser> createState() => _ItemChooserState();
}

class _ItemChooserState extends State<ItemChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buildTitle),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (widget.items.isEmpty)
            const Expanded(child: LottieViewer())
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    _onItemSelect(widget.items[index]);
                  },
                  child: _buildItemWidget(widget.items[index]),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: AddButtonDialog(
        onAddItem: _onAddDriver,
        type: widget.type,
      ),
    );
  }

  Widget _buildItemWidget(DatabaseObject item) {
    switch (item.type) {
      case ObjectType.bus:
        return BusItemWidget(item as Bus);
      case ObjectType.driver:
        return DriverItemWidget(item as Driver);
      default:
        return BusItemWidget(item as Bus);
    }
  }

  String get buildTitle {
    if (widget.items is List<Driver>) {
      return Languages.language.value.drivers;
    }
    if (widget.items is List<Bus>) {
      return Languages.language.value.buses;
    }
    return Languages.language.value.buses;
  }

  void _onItemSelect(DatabaseObject item) {
    Navigator.pop(context, item);
  }

  void _onAddDriver(DatabaseObject item) {
    setState(() {
      widget.items.insert(0, item);
    });
  }
}
