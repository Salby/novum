import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// Returns the user's 'newsapi.org' API key stored in
/// shared preferences.
Future<String> kNewsApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('news_api_key');
}