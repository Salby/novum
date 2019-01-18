import 'package:flutter/material.dart';
import '../navigation.dart';
import '../components/novum_app_bar.dart';
import '../components/article_list_builder.dart';
import '../components/article_list_skeleton.dart';
import '../../models/article_collection_model.dart';
import '../../blocs/article_collection_bloc.dart';

class Browse extends StatefulWidget {

  Browse({
    this.title,
    this.category,
    this.tag,
  });

  final String title;
  final String category;
  final String tag;

  @override
  BrowseState createState() => BrowseState();

}

class BrowseState extends State<Browse> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )
      ..addListener(() { setState(() {}); })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          controller.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Stack(
        children: <Widget>[

          StreamBuilder(
            stream: bloc.articles,
            builder: (BuildContext context, AsyncSnapshot<ArticleCollectionModel> snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    if (notification.scrollDelta < 0 && controller.isCompleted) {
                      controller.reverse();
                    } else if (notification.scrollDelta > 0 && controller.isDismissed) {
                      controller.forward();
                    }
                  },
                  child: ArticleListBuilder(
                    snapshot.data.articles,
                    itemCount: widget.category == null
                      ? 5
                      : null,
                  ),
                );
              }
              bloc.fetchArticles(category: widget.category ?? '');
              return ArticleListSkeleton(
                itemCount: widget.category == null
                  ? 5
                  : null,
              );
            }
          ),

          Align(
            alignment: Alignment.topCenter,
            child: MediaQuery.of(context).size.width == 0.0
              ? SafeArea(child: Container(width: double.infinity, height: 56.0))
              : NovumAppBar(
                title: widget.title,
                context: context,
                controller: controller,
              ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}