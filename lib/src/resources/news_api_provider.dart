import '../secrets/news_api_key.dart';
import '../models/article_collection_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class NewsApiProvider {
  
  Future<ArticleCollectionModel> request(Endpoint endpoint) async {
    final apiKey = await kNewsApiKey();
    final client = NewsapiClient(apiKey);
    final response = await client.request(endpoint);
    return ArticleCollectionModel.fromJson(response);
  }

  Future<bool> test(String apiKey) async {
    final client = NewsapiClient(apiKey);
    try {
      await client.request(TopHeadlines(
        country: Countries.unitedStatesOfAmerica,
      ));
      return true;
    } catch(e) {
      return false;
    }
  }

}