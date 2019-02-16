import 'dart:async';
import '../secrets/news_api_key.dart';

class AuthBloc {

  final StreamController<String> key = StreamController();

  getKey() async {
    final String _key = await kNewsApiKey();
    key.sink.add(_key);
  }

  dispose() {
    key.close();
  }

}