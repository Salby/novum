import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  Logo.full({
    this.title = 'Novum',
  })  : fontSize = 24.0,
        height = 1.0;
  Logo.compact({
    this.title: 'N',
  })  : fontSize = 26.0,
        height = 1.2;
  Logo.large({
    this.title: 'Novum',
  })  : fontSize = 34.0,
        height = 1.0;

  final String title;
  final double fontSize;
  final double height;

  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.display1.copyWith(
        fontSize: fontSize,
        height: height,
      ),
    ); 
  }

}