import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HandCashProvider {
  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<bool> setAuthToken(String authToken) async {
    if (authToken == null) return false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', authToken);
    return true;
  }
}
