import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/widgets/Dot.dart';
import 'package:flutter/material.dart';

class DriverPreviewer extends StatelessWidget {
  final Driver? driver;
  final String emptyTitle;
  final VoidCallback? onTap;

  const DriverPreviewer({
    Key? key,
    this.driver,
    this.emptyTitle = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.all(8),
      decoration: driver == null ? _unSelectDecoration() : _selectDecoration(),
      child: InkWell(
        splashColor: Colors.black26,
        splashFactory: InkSplash.splashFactory,
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: driver == null ? _buildEmptyView() : _buildPreview(),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.person_add_alt_1_rounded,
          size: 60,
          color: Colors.white,
        ),
        Text(
          emptyTitle,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_rounded,
              size: 60,
              color: Colors.black38,
            ),
            Text(
              driver?.name ?? '',
              style: const TextStyle(fontSize: 24, color: Colors.black38),
            ),
          ],
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Dot(color: driver?.status.color),
        ),
      ],
    );
  }

  BoxDecoration _selectDecoration() {
    return BoxDecoration(
      color: Colors.black12,
      border: Border.all(color: Colors.black26, width: 2),
      borderRadius: BorderRadius.circular(8),
    );
  }

  BoxDecoration _unSelectDecoration() {
    return BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
