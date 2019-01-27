import './article_model.dart';

class ArticleCollectionModel {

  ArticleCollectionModel.fromJson(Map<String, dynamic> parsedJson) :
    status = parsedJson['status'],
    results = parsedJson['results'],
    articles = _buildArticleModelList(parsedJson['articles']);

  final String status;
  final int results;
  final List<ArticleModel> articles;

  static List<ArticleModel> _buildArticleModelList(List articles) {
    List<ArticleModel> temp = [];
    for (Map _article in articles) {
      final ArticleModel article = ArticleModel.fromJson(_article);
      temp.add(article);
    }
    return temp;
  }

}