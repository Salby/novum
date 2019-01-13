import 'package:flutter/material.dart';

class SkeletonFrame extends StatefulWidget {

  SkeletonFrame({
    this.width,
    this.height,
  });

  final double width;
  final double height;

  @override
  _SkeletonFrameState createState() => _SkeletonFrameState();

}

class _SkeletonFrameState extends State<SkeletonFrame> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 1.0,
      end: 0.2,
    ).animate(controller)
      ..addListener(() { setState(() {}); })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.black26,
      ),
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

}