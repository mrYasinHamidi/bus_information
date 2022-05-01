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
  final List<MainObject> items;
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
  Size get size => MediaQuery.of(context).size;
  final TextEditingController _controller = TextEditingController();

  List<MainObject> get _searchedItems =>
      widget.items.where((element) => element.searchWord.toLowerCase().contains(_controller.text.trim().toLowerCase())).toList();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

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
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (widget.items.isEmpty)
            Expanded(
                child: LottieViewer(
              width: size.width * .5,
            ))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchedItems.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    _onItemSelect(_searchedItems[index]);
                  },
                  child: _buildItemWidget(_searchedItems[index]),
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

  Widget _buildItemWidget(MainObject item) {
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

  void _onItemSelect(MainObject item) {
    Navigator.pop(context, item);
  }

  void _onAddDriver(MainObject item) {
    setState(() {
      widget.items.insert(0, item);
    });
  }

  void _search(String text) {}
}
