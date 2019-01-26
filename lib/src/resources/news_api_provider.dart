import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/article_collection_model.dart';
import '../../secrets/news_api_key.dart';

class NewsApiProvider {
  
  Client client = Client();
  final String _apiKey = kNewsApiKey;
  final String url = 'https://newsapi.org/v2/';

  Future<ArticleCollectionModel> searchArticles(String query) async {
    final encodedQuery = Uri.encodeFull(query);
    final response = await client.get('${url}top-headlines?q=$encodedQuery&language=en&apiKey=$_apiKey');
    return _handleResponse(response);
  }

  Future<ArticleCollectionModel> fetchArticles({String category: ''}) async {
    String parameter;
    if (category != '') {
      parameter = 'category=$category&';
    } else {
      parameter = '';
    }
    final response = await client.get('${url}top-headlines?country=us&${parameter}apiKey=$_apiKey');
    return _handleResponse(response);
  }

  ArticleCollectionModel _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return ArticleCollectionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load response.');
    }
  }

}