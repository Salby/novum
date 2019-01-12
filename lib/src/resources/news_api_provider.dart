import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/article_collection_model.dart';
import '../../secrets/news_api_key.dart';

class NewsApiProvider {
  
  Client client = Client();
  final String _apiKey = kNewsApiKey;

  Future<ArticleCollectionModel> fetchArticles({String category: ''}) async {
    String parameter;
    if (category != '') {
      parameter = 'category=$category&';
    } else {
      parameter = '';
    }
    final response = await client.get('https://newsapi.org/v2/top-headlines?country=us&${parameter}apiKey=$_apiKey');
    if (response.statusCode == 200) {
      // Call was successful. Parse JSON.
      return ArticleCollectionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load articles');
    }
  }

}