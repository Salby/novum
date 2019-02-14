import '../secrets/news_api_key.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {

  final _keyFetcher = PublishSubject<String>();

  Observable<String> get key => _keyFetcher.stream;

  getKey() async {
    final String key = await kNewsApiKey();
    _keyFetcher.sink.add(key);
  }

  dispose() {
    _keyFetcher.close();
  }

}