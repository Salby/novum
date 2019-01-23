import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {

  FadeRoute(this.widget) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 200),
  );

  final Widget widget;

}