import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {

  Future<List<String>> getSymbols() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('symbols');
  }

  Future<bool> setSymbols({List<String> symbols = const ['AAPL', 'FB', 'GOOG']}) async {
    if (symbols == null)
      return false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('symbols', symbols);
    return true;
  }

}