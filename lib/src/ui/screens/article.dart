import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../components/article_tile.dart';
import 'package:flutter_villains/villain.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Article extends StatelessWidget {

  Article(this.article) : assert(article != null);

  final ArticleModel article;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Villain(
        villainAnimation:VillainAnimation.fromBottom(
          curve: Curves.fastOutSlowIn,
          relativeOffset: 0.05,
          from: Duration(milliseconds: 200),
          to: Duration(milliseconds: 400),
        ),
        secondaryVillainAnimation: VillainAnimation.fade(),
        animateExit: true,
        child: Stack(
          children: <Widget>[

            _content(context),

            _actions(context),

          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: Container(
          width: 56.0,
          height: 56.0,
          child: Material(
            elevation: 4.0,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0)),
            ),
            child: Row(
              children: <Widget>[

                IconButton(
                  icon: Theme.of(context).platform == TargetPlatform.iOS
                    ? Icon(Icons.arrow_back_ios)
                    : Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final String title = ArticleTile.cleanTitle(article.title);
    return ListView(
      children: <Widget>[

        // Article image.
        FadeInImage.memoryNetwork(
          image: article.imageUrl,
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
        ),

        // Title.
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(title, style: Theme.of(context).textTheme.headline.copyWith(
            height: 0.7,
          )),
        ),

        // Content.
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(article.content, style: Theme.of(context).textTheme.body1.copyWith(
            fontSize: 16.0,
            height: 1.4,
          )),
        ),

        Divider(),

        // Actions.
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Share.
              Flexible(
                flex: 1,
                child: FlatButton(
                  textColor: Theme.of(context).accentColor,
                  highlightColor: Theme.of(context).accentColor.withOpacity(0.12),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.12),
                  onPressed: () => _share(),
                  child: Text('Share'),
                ),
              ),

              SizedBox(width: 16.0),

              // Read full article.
              Flexible(
                flex: 2,
                child: RaisedButton(
                  colorBrightness: Brightness.dark,
                  color: Theme.of(context).accentColor,
                  onPressed: () => _launchUrl(context),
                  child: Text('Read full article'),
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }

  void _share() {
    Share.share(article.url);
  }

  void _launchUrl(BuildContext context) async {
    try {
      await launch(
        article.url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}