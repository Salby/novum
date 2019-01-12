import 'package:flutter/material.dart';
import './article_tile.dart';

class ArticleListSkeleton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 3,
      padding: EdgeInsets.all(20.0),
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return ArticleTile(
          title: Container(width: 200.0, height: 16.0, color: Colors.black26),
          published: Container(width: 36.0, height: 16.0, color: Colors.black26),
          thumbnail: Container(width: 100.0, height: 100.0, color: Colors.transparent),
          expanded: index == 0,
        );
      },
    );
  }

}