import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import './article_tile.dart';
import './skeleton_frame.dart';

class ArticleList extends StatelessWidget {

  ArticleList(this.articles, {
    this.expandFirst: true,
    this.itemCount,
    this.padding: const EdgeInsets.symmetric(vertical: 20.0),
  }) : assert(articles != null);

  ArticleList.skeleton({
    this.expandFirst: true,
    this.itemCount,
    this.padding: const EdgeInsets.symmetric(vertical: 20.0),
  }) : articles = null;

  final List<ArticleModel> articles;
  final bool expandFirst;
  final int itemCount;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final bool skeleton = articles == null;
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: skeleton
        ? itemCount ?? 4
        : itemCount ?? articles.length,
      padding: padding,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        if (skeleton) {
          // Return skeleton tile.
          return ArticleTile(
            title: index == 0
              ? SkeletonFrame(width: 300.0, height: 16.0)
              : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SkeletonFrame(width: 300.0, height: 16.0),
                  SizedBox(height: 4.0),
                  SkeletonFrame(width: 150.0, height: 16.0),
                ],
              ),
            published: SkeletonFrame(width: 36.0, height: 16.0),
            thumbnail: Container(width: 100.0, height: 100.0),
            expanded: expandFirst && index == 0,
          );
        } else {
          // Return regular tile with content.
          return ArticleTile.fromArticleModel(
            articles[index],
            context,
            expanded: expandFirst && index == 0,
          );
        }
      },
    );
  }

}