import '../models/article_collection_model.dart';
import '../../secrets/news_api_key.dart';
import 'package:newsapi_client/newsapi_client.dart';

class NewsApiProvider {
  
  final client = NewsapiClient(kNewsApiKey);

  Future<ArticleCollectionModel> request(Endpoint endpoint) async {
    final response = await client.request(endpoint);
    return ArticleCollectionModel.fromJson(response);
  }

}