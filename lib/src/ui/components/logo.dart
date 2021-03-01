import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo.full({
    this.title = 'News App',
  }) : fontSize = 24.0;
  Logo.compact({
    this.title: 'N',
  }) : fontSize = 26.0;
  Logo.large({
    this.title: 'News App',
  }) : fontSize = 34.0;

  final String title;
  final double fontSize;

  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.display1.copyWith(
            fontSize: fontSize,
          ),
    );
  }
}
