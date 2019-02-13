import 'package:flutter/material.dart';
import './colors.dart';

ThemeData kNovumTheme = _buildNovumTheme();

ThemeData _buildNovumTheme() {

  final base = ThemeData.light();

  return base.copyWith(

    brightness: Brightness.light,

    primaryColor: kNovumWhite,
    primaryColorBrightness: Brightness.light,
    accentColor: kNovumPurple,
    accentColorBrightness: Brightness.dark,
    
    scaffoldBackgroundColor: kNovumWhite,

    dividerColor: Colors.black26,

    splashColor: Colors.black12,
    highlightColor: Colors.black12,

    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),

    iconTheme: base.iconTheme.copyWith(
      color: Colors.black87,
    ),
    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: Colors.black87,
    ),
    accentIconTheme: base.accentIconTheme.copyWith(
      color: kNovumPurple,
    ),

    buttonTheme: base.buttonTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),

    cursorColor: kNovumPurple,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(
        width: 1.0,
        color: Colors.black26,
      )),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
        width: 1.0,
        color: Colors.black26,
      )),
      hasFloatingPlaceholder: false,
    ),

    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),

  );

}

TextTheme _buildTextTheme(TextTheme base) {

  return base.copyWith(

    display4: base.display4.copyWith(
      fontFamily: 'Eczar',
      fontWeight: FontWeight.w600,
    ),
    display3: base.display3.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w300,
    ),
    display2: base.display2.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w500,
    ),
    display1: base.display1.copyWith(
      fontFamily: 'Eczar',
      fontWeight: FontWeight.w600,
    ),

    headline: base.headline.copyWith(
      fontFamily: 'Eczar',
      fontWeight: FontWeight.w600,
    ),

    subtitle: base.subtitle.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w500,
    ),

    body1: base.body1.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontFamily: 'Eczar',
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
    ),

    button: base.button.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w700,
    ),

    caption: base.caption.copyWith(
      fontFamily: 'Eczar',
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    ),

    overline: base.overline.copyWith(
      fontFamily: 'Libre Franklin',
      fontWeight: FontWeight.w700,
      fontSize: 10.0,
    ),

  ).apply(

    displayColor: Colors.black87,
    bodyColor: Colors.black87,

  );

}