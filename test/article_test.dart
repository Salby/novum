import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:novum/src/ui/screens/article.dart';
import 'package:novum/src/models/article_model.dart';

void main() {

  Map<String, dynamic> articleJson;

  setUpAll(() {
    articleJson = {
      'author': 'John Doe',
      'title': 'This is a fake article',
      'description': 'Lorem ipsum.',
      'source': {
        'name': 'example.com',
      },
      'url': 'https://example.com',
      'urlToImage': null,
      'publishedAt': '2019-09-09',
      'content': 'Lorem ipsum.',
    };
  });

  group('Missing parts of the article.', () {

    testWidgets('Article screen displays image placeholder if image is missing.', (WidgetTester tester) async {
      final fakeArticle = ArticleModel.fromJson(articleJson);
      await tester.pumpWidget(MaterialApp(home: Article(fakeArticle)));
      expect(find.text('No image'), findsOneWidget);
    });

    testWidgets('Article-screen displays title placeholder if title is missing.', (WidgetTester tester) async {
      final tempArticleJson = articleJson;
      tempArticleJson['title'] = null;
      final fakeArticle = ArticleModel.fromJson(tempArticleJson);
      await tester.pumpWidget(MaterialApp(home: Article(fakeArticle)));
      expect(find.text('(No title)'), findsOneWidget);
    });

  });

  testWidgets('Article-screen handles category correctly', (WidgetTester tester) async {
    final fakeArticle = ArticleModel.fromJson(articleJson);
    await tester.pumpWidget(MaterialApp(
      home: Article(fakeArticle, category: 'lasagna'),
    ));
    expect(find.text('LASAGNA'), findsOneWidget);
  });

}