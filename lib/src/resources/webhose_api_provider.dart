import 'dart:async';
import 'dart:convert';
import 'package:novum/src/models/article_model.dart';
import 'package:novum/src/resources/news_api_provider.dart';

import '../models/article_collection_model.dart';
import 'package:newsapi_client/newsapi_client.dart';
import 'package:http/http.dart' as http;

class WebhoseApiProvider extends NewsApiProvider {
  static final String endpoint =
      'https://webhose.io/filterWebContent?token=376a1b6c-bcb7-4069-9b24-b8c2f6356e78&format=json&ts=1614184632408&sort=social.facebook.likes&q=thread.country%3AES%20language%3Aspanish%20num_chars%3A%3E5000';

  final List<ArticleModel> cachedArticles = [];

  Future<ArticleCollectionModel> request(Endpoint _) async {
    if (cachedArticles.isEmpty) {
      return _fetchArticles();
    }
    return ArticleCollectionModel(status: "200", results: cachedArticles.length, articles: cachedArticles);
  }

  Future<ArticleCollectionModel> _fetchArticles() async {
    final response = await http.get(endpoint);
    print(endpoint + ' - ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['posts'].forEach((item) {
        cachedArticles.add(ArticleModel(
          author: item['author'],
          title: item['title'],
          imageUrl: item['thread']['main_image'],
          source: item['thread']['site'],
          url: item['url'],
          published: DateTime.parse(item['published']),
          content: item['text'],
          description: item['thread']['title_full'],
        ));
      });
    }
    return ArticleCollectionModel(
        status: response.statusCode.toString(), results: cachedArticles.length, articles: cachedArticles);
  }
}
