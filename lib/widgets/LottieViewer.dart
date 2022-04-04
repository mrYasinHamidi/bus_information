import 'package:bus_information/models/enums/LottieName.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieViewer extends StatefulWidget {
  final LottieName name;
  final double? width;
  final double? height;

  const LottieViewer({
    Key? key,
    this.name = LottieName.noContent,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<LottieViewer> createState() => _LottieViewerState();
}

class _LottieViewerState extends State<LottieViewer> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/${widget.name.name}.json',
      width: widget.width,
      // height: widget.height,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
