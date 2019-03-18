import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/theme_model.dart';
import './colors.dart';

class Themes {

  static ThemeModel get light => _buildNovumTheme(Brightness.light);
  static ThemeModel get dark => _buildNovumTheme(Brightness.dark);
  static ThemeModel platform(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return _buildNovumTheme(brightness);
  }

}

ThemeModel _buildNovumTheme(Brightness brightness) {

  final bool light = brightness == Brightness.light;

  final base = light ? ThemeData.light() : ThemeData.dark();

  final ThemeData theme = base.copyWith(

    brightness: brightness,

    primaryColor: light ? kNovumWhite : Colors.grey[900],
    primaryColorBrightness: brightness,
    accentColor: light ? kNovumPurple : kNovumPurpleLight,
    accentColorBrightness: light ? Brightness.dark : Brightness.dark,

    scaffoldBackgroundColor: light ? kNovumWhite : Colors.grey[900],

    dividerColor: light ? Colors.black26 : Colors.white24,

    splashColor: light ? Colors.black12 : Colors.white10,
    highlightColor: light ? Colors.black12 : Colors.white10,

    textTheme: _buildTextTheme(base.textTheme, brightness),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, brightness),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, brightness),

    iconTheme: base.iconTheme.copyWith(
      color: light ? Colors.black87 : Colors.white,
    ),
    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: light ? Colors.black87 : Colors.white,
    ),
    accentIconTheme: base.accentIconTheme.copyWith(
      color: light ? kNovumPurple : kNovumPurpleLight,
    ),

    buttonTheme: base.buttonTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),

    cursorColor: kNovumPurple,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(
        width: 1.0,
        color: light ? Colors.black26 : Colors.white24,
      )),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
        width: 1.0,
        color: light ? Colors.black26 : Colors.white24,
      )),
      hasFloatingPlaceholder: false,
    ),

    dialogBackgroundColor: light ? Colors.white : Colors.grey[850],
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),

  );

  final SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: light ? Brightness.dark : Brightness.light,
    statusBarColor: light ? Colors.grey[100] : Colors.grey[900],
    systemNavigationBarColor: light ? kNovumWhite : Colors.grey[900],
    systemNavigationBarIconBrightness: light ? Brightness.dark : Brightness.dark,
  );

  return ThemeModel(
    theme: theme,
    uiStyle: uiStyle,
  );

}

TextTheme _buildTextTheme(TextTheme base, Brightness brightness) {

  final bool light = brightness == Brightness.light;

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

    displayColor: light ? Colors.black87 : Colors.white,
    bodyColor: light ? Colors.black87 : Colors.white,

  );

}