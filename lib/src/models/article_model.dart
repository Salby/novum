class ArticleModel {

  ArticleModel.fromJson(Map<String, dynamic> parsedJson) {
    author = parsedJson['author'];
    title = parsedJson['title'];
    description = parsedJson['description'];
    source = parsedJson['source']['name'];
    url = parsedJson['url'];
    imageUrl = parsedJson['urlToImage'];
    published = parsedJson['publishedAt'];
    content = parsedJson['content'];
  }

  String author;
  String title;
  String description;
  String source;
  String url;
  String imageUrl;
  String published;
  String content;

  /*String get author => _author;
  String get title => _title;
  String get description => _description;
  String get source => _source;
  String get url => _url;
  String get imageUrl => _imageUrl;
  String get published => _published;
  String get content => _content;*/

}