import '../models/article_collection_model.dart';
import '../../secrets/news_api_key.dart';
import 'package:newsapi_client/newsapi_client.dart';

class NewsApiProvider {
  
  final client = NewsapiClient(kNewsApiKey);

  Future<ArticleCollectionModel> searchArticles(String query) async {
    final now = DateTime.now();
    final response = await client.request(Everything(
      query: query,
      from: now.subtract(Duration(days: 10)),
      to: now,
    ));
    return ArticleCollectionModel.fromJson(response);
  }

  Future<ArticleCollectionModel> topHeadlines({Categories category}) async {
    final response = await client.request(TopHeadlines(
      language: 'en',
      category: category ?? null,
    ));
    return ArticleCollectionModel.fromJson(response);
  }

}