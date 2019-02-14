import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {

  FadeRoute(this.widget, {this.duration = const Duration(milliseconds: 200)}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: duration,
  );

  final Widget widget;
  final Duration duration;

}