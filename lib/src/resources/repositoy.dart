import './news_api_provider.dart';
import '../models/article_collection_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class Repository {

  final newsApiProvider = NewsApiProvider();

  Future<ArticleCollectionModel> searchArticles(String query) async {
    return newsApiProvider.searchArticles(query);
  }
  Future<ArticleCollectionModel> fetchArticles({Categories category}) async {
    return newsApiProvider.topHeadlines(category: category);
  }

}