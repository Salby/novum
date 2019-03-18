import 'dart:async';
import 'package:flutter/material.dart' show BuildContext;
import '../resources/shared_preferences_provider.dart';
import '../models/theme_model.dart';
import '../ui/theme/theme.dart';

class ThemeBloc {

  final _prefsProvider = SharedPreferencesProvider();

  final _theme = StreamController<ThemeModel>();

  Stream<ThemeModel> get theme => _theme.stream;

  Future<void> getTheme(BuildContext context) async {
    final code = await _prefsProvider.getTheme();
    if (code == 'light') {
      _theme.sink.add(Themes.light);
    } else if (code == 'dark') {
      _theme.sink.add(Themes.dark);
    } else {
      _theme.sink.add(Themes.platform(context));
    }
  }

  Future<void> setTheme(String code, BuildContext context) async {
    await _prefsProvider.setTheme(code);
    if (code == 'light') {
      _theme.sink.add(Themes.light);
    } else if (code == 'dark') {
      _theme.sink.add(Themes.dark);
    } else {
      _theme.sink.add(Themes.platform(context));
    }
  }

  void dispose() {
    _theme.close();
  }

}