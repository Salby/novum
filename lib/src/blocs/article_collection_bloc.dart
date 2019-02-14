import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/article_collection_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class ArticleCollectionBloc {

  final _repository = Repository();
  final _articleFetcher = PublishSubject<ArticleCollectionModel>();

  Observable<ArticleCollectionModel> get articles => _articleFetcher.stream;

  requestArticles(TopHeadlines endpoint) async {
    ArticleCollectionModel articleCollection = await _repository.newsApiRequest(endpoint);
    _articleFetcher.sink.add(articleCollection);
  }
  searchArticles(String query) async {
    final DateTime now = DateTime.now();
    ArticleCollectionModel articleCollection = await _repository.newsApiRequest(Everything(
      query: query,
      from: now.subtract(Duration(days: 14)),
      to: now,
    ));
    _articleFetcher.sink.add(articleCollection);
  }

  dispose() {
    _articleFetcher.close();
  }

}