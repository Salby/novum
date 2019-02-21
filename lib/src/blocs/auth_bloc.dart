import 'dart:async';
import '../secrets/news_api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {

  final StreamController<String> _key = StreamController();

  Stream<String> get key => _key.stream;

  getKey() async {
    final String key = await kNewsApiKey();
    _key.sink.add(key);
  }
  setKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('news_api_key', key);
    _key.sink.add(key);
  }

  dispose() {
    _key.close();
  }

}