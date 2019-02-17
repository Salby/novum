import 'dart:async';
import '../secrets/news_api_key.dart';

class AuthBloc {

  final StreamController<String> _key = StreamController();

  Stream<String> get key => _key.stream;

  getKey() async {
    final String key = await kNewsApiKey();
    _key.sink.add(key);
  }

  dispose() {
    _key.close();
  }

}