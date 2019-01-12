import 'package:flutter/material.dart';
import '../navigation.dart';
import '../../blocs/article_collection_bloc.dart';
import '../../models/article_collection_model.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Novum',
          style: Theme.of(context).textTheme.display1.copyWith(
            fontSize: 24.0,
          ),
        ),
        actions: <Widget>[
          // Search button.
          IconButton(
            icon: Icon(Icons.search, semanticLabel: 'Search'),
            onPressed: () {
              print('Pressed \'search\'');
            },
            tooltip: 'Search',
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.articles,
        builder: (BuildContext context, AsyncSnapshot<ArticleCollectionModel> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text('Fetched articles.'),
            );
          }
          bloc.fetchArticles(category: 'technology');
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

}