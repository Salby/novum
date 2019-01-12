import './article_model.dart';

class ArticleCollectionModel {

  ArticleCollectionModel.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    results = parsedJson['totalResults'];
    List<dynamic> _articles = parsedJson['articles'];
    List<ArticleModel> _temp = [];
    for (Map _article in _articles) {
      final ArticleModel article = ArticleModel.fromJson(_article);
      _temp.add(article);
    }
    articles = _temp;
  }

  String status;
  int results;
  List<ArticleModel> articles;

}