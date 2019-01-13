import 'package:flutter/material.dart';
import './article_tile.dart';
import './skeleton_frame.dart';

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
          expanded: index == 0,
        );
      },
    );
  }

}