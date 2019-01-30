import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:novum/src/ui/screens/article.dart';
import 'package:novum/src/models/article_model.dart';

void main() {

  group('Missing parts of the article.', () {
    Map<String, dynamic> articleJson;

    setUp(() {
      articleJson = {
        'author': 'John Doe',
        'title': 'This is a fake article',
        'description': 'Lorem ipsum.',
        'source': {
          'name': 'example.com',
        },
        'url': 'https://example.com',
        'urlToimage': null,
        'publishedAt': '2019-09-09',
        'content': 'Lorem ipsum.',
      };
    });

    testWidgets('Article screen displays article without image', (WidgetTester tester) async {
      final fakeArticle = ArticleModel.fromJson(articleJson);
      await tester.pumpWidget(MaterialApp(home: Article(fakeArticle)));
      expect(find.text('Lorem ipsum.'), findsOneWidget);
    });

    testWidgets('Article screen displays title placeholder if title is missing', (WidgetTester tester) async {
      final tempArticleJson = articleJson;
      tempArticleJson['title'] = null;
      final fakeArticle = ArticleModel.fromJson(tempArticleJson);
      await tester.pumpWidget(MaterialApp(home: Article(fakeArticle)));
      expect(find.text('(No title)'), findsOneWidget);
    });

  });

}