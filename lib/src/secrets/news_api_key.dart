import 'package:shared_preferences/shared_preferences.dart';

Future<String> kNewsApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('news_api_key');
}