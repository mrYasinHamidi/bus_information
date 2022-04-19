import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  final Color? color;
  final String? name;
  final VoidCallback? onTap;
  final double padding;
  final double? size;
  final EdgeInsetsGeometry? edgePadding;

  const SvgViewer({
    Key? key,
    this.color,
    this.edgePadding,
    this.name,
    this.onTap,
    this.size,
    this.padding = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (name == null) return const SizedBox();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: edgePadding ?? EdgeInsetsDirectional.all(padding),
        color: Colors.transparent,
        child: SvgPicture.asset(
          'assets/icons/$name.svg',
          fit: BoxFit.contain,
          color: color,
          width: size,
          height: size,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
