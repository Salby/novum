import 'package:flutter/material.dart';
import '../../models/article_collection_model.dart';
import '../../blocs/article_collection_bloc.dart';
import '../components/article_list_builder.dart';
import '../components/article_list_skeleton.dart';
import '../components/logo.dart';

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        elevation: 0.0,
        title: Logo.full(),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SearchBody(),
    );
  }

}

class SearchBody extends StatefulWidget {

  @override
  SearchBodyState createState() => SearchBodyState();

}

class SearchBodyState extends State<SearchBody> {

  TextEditingController textController = TextEditingController();
  final searchBloc = ArticleCollectionBloc();

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder inputBorder = UnderlineInputBorder(borderSide: BorderSide(
      width: 1.0,
      color: Theme.of(context).dividerColor,
    ));
    final padding = EdgeInsets.symmetric(vertical: 20.0);
    return ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: TextField(
            autofocus: true,
            cursorColor: Theme.of(context).accentColor,
            style: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 24.0,
            ),
            decoration: InputDecoration(
              focusedBorder: inputBorder,
              border: inputBorder,
              hasFloatingPlaceholder: false,
              hintText: 'Search',
            ),
            controller: textController,
            onChanged: (value) => _handleChange(value),
          ),
        ),

        StreamBuilder(
          stream: searchBloc.articles,
          builder: (BuildContext context, AsyncSnapshot<ArticleCollectionModel> snapshot) {
            if (snapshot.hasData) {
              return ArticleListBuilder(
                snapshot.data.articles, 
                expanded: false,
                padding: padding
              );
            }
            if (textController.value.text.isNotEmpty) {
              return ArticleListSkeleton(expanded: false);
            }
            return Container(padding: padding);
          },
        ),

      ],
    );
  }

  void _handleChange(String value) async {
    if (value.isNotEmpty) {
      final String query = value;
      await Future.delayed(Duration(milliseconds: 500));
      if (query == textController.value.text) {
        searchBloc.searchArticles(query);
      }
    }
  }

}