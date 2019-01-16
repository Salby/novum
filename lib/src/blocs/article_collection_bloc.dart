import 'package:rxdart/rxdart.dart';
import '../resources/repositoy.dart';
import '../models/article_collection_model.dart';

class ArticleCollectionBloc {

  final _repository = Repository();
  final _articleFetcher = PublishSubject<ArticleCollectionModel>();

  Observable<ArticleCollectionModel> get articles => _articleFetcher.stream;

  fetchArticles({String category: ''}) async {
    ArticleCollectionModel articleCollection = await _repository.fetchArticles(category: category);
    _articleFetcher.sink.add(articleCollection);
  }
  searchArticles(String query) async {
    ArticleCollectionModel articleCollection = await _repository.searchArticles(query);
    _articleFetcher.sink.add(articleCollection);
  }

  dispose() {
    _articleFetcher.close();
  }

}

final bloc = ArticleCollectionBloc();