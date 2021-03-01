class ArticleModel {
  final String author;
  final String title;
  final String description;
  final String source;
  final String url;
  final String imageUrl;
  final DateTime published;
  final String content;

  ArticleModel(
      {this.author, this.title, this.description, this.source, this.url, this.imageUrl, this.published, this.content});

  ArticleModel.fromJson(Map<String, dynamic> parsedJson)
      : author = parsedJson['author'],
        title = parsedJson['title'],
        description = parsedJson['description'],
        source = parsedJson['source']['name'],
        url = parsedJson['url'],
        imageUrl = parsedJson['urlToImage'],
        published = _parsedDate(parsedJson['publishedAt']),
        content = parsedJson['content'];

  static DateTime _parsedDate(String timestamp) {
    DateTime parsed;
    try {
      parsed = DateTime.parse(timestamp);
    } catch (e) {
      parsed = DateTime.now();
    }
    return parsed;
  }
}
