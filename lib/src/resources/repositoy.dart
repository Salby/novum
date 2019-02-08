import './news_api_provider.dart';
import '../models/article_collection_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class Repository {

  final newsApiProvider = NewsApiProvider();

  Future<ArticleCollectionModel> newsApiRequest(Endpoint endpoint) async {
    final response = await newsApiProvider.request(endpoint);
    return response;
  }

}