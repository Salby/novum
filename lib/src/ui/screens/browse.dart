import 'dart:async';
import 'package:flutter/material.dart';
import '../components/navigation_drawer.dart';
import '../components/novum_app_bar.dart';
import '../components/article_list.dart';
import '../components/iex_stock_data.dart';
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
  final bloc = ArticleCollectionBloc();

  @override
  BrowseState createState() => BrowseState();

}

class BrowseState extends State<Browse> with SingleTickerProviderStateMixin {

  /// The [_controller] controls the state of the
  /// [NovumAppBar].
  ///
  /// If [_controller.isCompleted] the app bar is
  /// collapsed.
  ///
  /// If [_controller.isDismissed] the app bar is
  /// expanded.
  AnimationController _controller;
  int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )
      ..addListener(() { setState(() {}); })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final listPadding = const EdgeInsets.only(top: 67.0, bottom: 20.0);
    final Widget readMore = widget.category != null
        ? FlatButton(
          child: Text(
            'Read More',
            style: Theme.of(context).textTheme.button.copyWith(
              fontSize: 18.0,
            ),
          ),
          onPressed: () => _moreContent(),
        )
        : Container();
    final Widget stocks = widget.category == null
        ? IexStockData()
        : Container();

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
            /// [_controller.reverse()] expands the app bar.
            /// [_controller.forward()] collapses the app bar.
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {

                final bool scrollingDown =
                  notification.scrollDelta > 0
                  && _controller.isDismissed
                  && notification.metrics.pixels > 0.0;
                final bool scrollingUp =
                  notification.scrollDelta < 0
                  && _controller.isCompleted
                  && notification.metrics.pixels < notification.metrics.maxScrollExtent;
                final bool overflowTop =
                  notification.metrics.pixels < 1.0;

                if (overflowTop) {
                  _controller.reverse();
                } else if (scrollingUp) {
                  _controller.reverse();
                } else if (scrollingDown) {
                  _controller.forward();
                }
              },
              child: ListView(
                children: <Widget>[

                  /// Builds list of articles from [bloc.articles].
                  /// Shows skeleton-screen if stream is empty.
                  StreamBuilder(
                    stream: widget.bloc.articles,
                    builder: (BuildContext context, AsyncSnapshot<ArticleCollectionModel> snapshot) {
                      if (snapshot.hasData) {
                        return ArticleList(
                          snapshot.data.articles,
                          padding: listPadding,
                          itemCount: snapshot.data.articles.length,
                        );
                      }
                      _refreshContent();
                      return ArticleList.skeleton(
                        padding: listPadding,
                        itemCount: 5,
                      );
                    }
                  ),

                  readMore,

                  Divider(),

                  stocks,

                ],
              ),
            ),
          ),

          /// Custom app bar
          /// 
          /// Appears when [MediaQuery] is available (doesn't return 0.0).
          Align(
            alignment: Alignment.topCenter,
            child: MediaQuery.of(context).size.width == 0.0
              ? SafeArea(child: Container(width: double.infinity, height: 56.0))
              : NovumAppBar(
                title: widget.title,
                context: context,
                controller: _controller,
              ),
          ),

        ],
      ),
    );
  }

  /// Submits a new article request with an increased
  /// pageSize.
  void _moreContent({int step: 10}) {
    setState(() {
      _pageSize = _pageSize += step;
    });
    widget.bloc.requestArticles(TopHeadlines(
      country: Countries.unitedStatesOfAmerica,
      category: widget.category,
      pageSize: _pageSize,
    ));
  }

  /// Refresh content
  /// 
  /// Refreshes the [bloc.articles] stream.
  Future<Null> _refreshContent() async {
    Endpoint endpoint;
    if (widget.category == null) {
      endpoint = TopHeadlines(
        country: Countries.unitedStatesOfAmerica,
        pageSize: 5,
      );
    } else {
      endpoint = TopHeadlines(
        country: Countries.unitedStatesOfAmerica,
        category: widget.category,
      );
    }
    await widget.bloc.requestArticles(endpoint);
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}