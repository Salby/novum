import 'package:flutter/material.dart';
import '../components/navigation_drawer.dart';
import '../components/novum_app_bar.dart';
import '../components/article_list.dart';
import '../../models/article_collection_model.dart';
import '../../blocs/article_collection_bloc.dart';
import 'package:newsapi_client/newsapi_client.dart';

class Browse extends StatefulWidget {

  Browse({
    this.title,
    this.category,
  });

  final String title;
  final Categories category;

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
    final listPadding = EdgeInsets.only(top: 67.0, bottom: 20.0);
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Stack(
        children: <Widget>[

          RefreshIndicator(
            displacement: 108.0,
            onRefresh: () => _refreshContent(),

            /// The NotificationListener listens for scroll updates
            /// and determines if the app bar should expand or collapse
            /// depending on the scroll direction.
            /// 
            /// [controller.reverse()] expands the app bar.
            /// [controller.forward()] collapses the app bar.
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {

                final bool scrollingDown =
                  notification.scrollDelta > 0
                  && controller.isDismissed
                  && notification.metrics.pixels > 0.0;
                final bool scrollingUp =
                  notification.scrollDelta < 0
                  && controller.isCompleted
                  && notification.metrics.pixels < notification.metrics.maxScrollExtent;
                final bool overflowTop =
                  notification.metrics.pixels < 1.0;

                if (overflowTop) {
                  controller.reverse();
                } else if (scrollingUp) {
                  controller.reverse();
                } else if (scrollingDown) {
                  controller.forward();
                }
              },
              child: ListView(
                children: <Widget>[

                  /// Builds list of articles from [bloc.articles].
                  /// Shows skeleton-screen if stream is empty.
                  StreamBuilder(
                    stream: bloc.articles,
                    builder: (BuildContext context, AsyncSnapshot<ArticleCollectionModel> snapshot) {
                      if (snapshot.hasData) {
                        return ArticleList(
                          snapshot.data.articles,
                          padding: listPadding,
                          itemCount: widget.category == null
                            ? 5
                            : null,
                        );
                      }
                      _refreshContent();
                      return ArticleList.skeleton(
                        padding: listPadding,
                        itemCount: 5,
                      );
                    }
                  ),

                  Divider(),

                  // TODO: Add stock market graph here when complete.

                ],
              ),
            ),
          ),

          /// Custom app bar
          /// 
          /// Appears when MediaQuery is availabe (doesn't return 0.0).
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

  /// Refresh content
  /// 
  /// Refreshes the [bloc.articles] stream.
  Future<Null> _refreshContent() async {
    await bloc.topHeadlines(category: widget.category ?? null);
    return null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}