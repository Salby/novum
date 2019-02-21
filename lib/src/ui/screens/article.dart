import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../components/article_tile.dart';
import '../components/image_placeholder.dart';
import 'package:flutter_villains/villain.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Article extends StatelessWidget {
  Article(this.article, {
    this.category
  }) : assert(article != null);

  final ArticleModel article;
  final String category;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Villain(
        villainAnimation: VillainAnimation.fromBottom(
          curve: Curves.fastOutSlowIn,
          relativeOffset: 0.05,
          from: Duration(milliseconds: 200),
          to: Duration(milliseconds: 400),
        ),
        secondaryVillainAnimation: VillainAnimation.fade(),
        animateExit: true,
        child: Stack(
          children: <Widget>[

            _Content(article, category: category ?? null),

            _BottomSheet(url: article.url),
            
            _Actions(actions: [
              IconButton(
                icon: Theme.of(context).platform == TargetPlatform.iOS
                  ? Icon(Icons.arrow_back_ios)
                  : Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ]),

          ],
        ),
      ),
    );
  }

}

class _Content extends StatelessWidget {

  _Content(this.article, {
    this.category,
  }) : assert(article != null);

  final ArticleModel article;
  final String category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        image(),

        articleCategory(context),

        SizedBox(height: 24.0),

        title(context),

        SizedBox(height: 8.0),

        source(context),

        SizedBox(height: 20.0),

        preview(context),

      ],
    );
  }

  Widget source(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        article.source != null
          ? 'Source: ${article.source}'
          : 'Error: No source found.',
        style: Theme.of(context).textTheme.body1.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget image() {
    if (article.imageUrl != null) {
      return FadeInImage.memoryNetwork(
        image: article.imageUrl,
        placeholder: kTransparentImage,
        fit: BoxFit.cover,
      );
    } else {
      return ImagePlaceholder(
        'No image',
        height: 200.0,
      );
    }
  }

  Widget preview(BuildContext context) {
    if (article.content != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          article.content,
          style: Theme.of(context).textTheme.body1.copyWith(
            fontSize: 16.0,
            height: 1.3,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget articleCategory(BuildContext context) {
    List<String> categories = ['us'];
    if (category != null) {
      if (category == 'home') {
        categories.add('front page');
      } else {
        categories.add(category);
      }
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 38.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) {
          return Text(
            '  ¬  ',
            style: Theme.of(context).textTheme.overline.copyWith(
              color: Colors.black54,
              fontSize: 13.0,
              height: 2.8,
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Text(
            categories[index].toUpperCase(),
            style: Theme.of(context).textTheme.overline.copyWith(
              fontSize: 13.0,
              height: 2.9,
            ),
          );
        },
      ),
    );
  }

  Widget title(BuildContext context) {
    final String title = article.title != null
      ? ArticleTile.cleanTitle(article.title)
      : '(No title)';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline.copyWith(
          height: 0.7,
        ),
      ),
    );
  }

}

class _BottomSheet extends StatelessWidget {

  _BottomSheet({
    @required this.url,
  }) : assert(url != null);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Material(
            color: Theme.of(context).cardColor,
            elevation: 24.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                  FlatButton(
                    textColor: Theme.of(context).accentColor,
                    child: Text('Share'),
                    onPressed: () => _share(),
                  ),

                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    colorBrightness: Brightness.dark,
                    child: Text('Full article'),
                    onPressed: () => _launchUrl(context),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _share() {
    Share.share(url);
  }

  void _launchUrl(BuildContext context) async {
    try {
      await launch(
        url,
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

class _Actions extends StatelessWidget {
  
  _Actions({
    this.actions,
  })  : assert(actions != null),
        assert(actions.isNotEmpty);

  final List<IconButton> actions;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: Container(
          width: 56.0 * actions.length,
          height: 56.0,
          child: Material(
            color: Theme.of(context).primaryColor,
            elevation: 4.0,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0)),
            ),
            child: ListView.builder(
              itemCount: actions.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return actions[index];
              },
            ),
          ),
        ),
      ),
    );
  }

}
