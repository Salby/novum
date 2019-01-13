import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../components/article_tile.dart';
import 'package:flutter_villains/villain.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Article extends StatelessWidget {

  Article({
    @required this.article,
    this.tag,
  }) : assert(article != null);

  final ArticleModel article;
  final String tag;

  Widget build(BuildContext context) {
    final String title = ArticleTile.cleanTitle(article.title);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Source: ' + article.source, style: TextStyle(
          color: Colors.black54,
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, semanticLabel: 'Label'),
            color: Theme.of(context).accentColor,
            tooltip: 'Share',
            onPressed: () => _share(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[

          // Article image.
          Hero(
            tag: tag,
            child: FadeInImage.memoryNetwork(
              image: article.imageUrl,
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
            ),
          ),

          // Title.
          Villain(
            villainAnimation: VillainAnimation.fade(
              fadeFrom: 0.0,
              fadeTo: 1.0,
              from: Duration(milliseconds: 500),
              to: Duration(milliseconds: 750),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(title, style: Theme.of(context).textTheme.headline.copyWith(
                height: 0.7,
              )),
            ),
          ),

          // Content.
          Villain(
            villainAnimation: VillainAnimation.fade(
              fadeFrom: 0.0,
              fadeTo: 1.0,
              from: Duration(milliseconds: 750),
              to: Duration(milliseconds: 1000),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(article.content, style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 16.0,
                height: 1.4,
              )),
            ),
          ),

          // Actions.
          Villain(
            villainAnimation: VillainAnimation.fade(
              fadeFrom: 0.0,
              fadeTo: 1.0,
              from: Duration(milliseconds: 1000),
              to: Duration(milliseconds: 1250),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
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
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0)),
                      ),
                      colorBrightness: Brightness.dark,
                      color: Theme.of(context).accentColor,
                      onPressed: () => _launchUrl(context),
                      child: Text('Read full article'),
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
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