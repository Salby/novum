import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeModel {

  ThemeModel({
    this.uiStyle,
    this.theme,
  });

  final SystemUiOverlayStyle uiStyle;
  final ThemeData theme;

}