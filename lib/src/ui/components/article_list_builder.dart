import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import './article_tile.dart';

class ArticleListBuilder extends StatelessWidget {

  ArticleListBuilder(this.articles, {
    this.expanded: true,
    this.itemCount,
    this.padding,
  });

  final List<ArticleModel> articles;
  final bool expanded;
  final int itemCount;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: itemCount ?? articles.length,
      padding: padding ?? EdgeInsets.only(top: 90.0),
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.symmetric(horizontal: 20.0), child: Divider());
      },
      itemBuilder: (BuildContext context, int index) {
        return ArticleTile.fromArticleModel(
          articles[index],
          context,
          expanded: expanded && index == 0,
        );
      },
    );
  }

}