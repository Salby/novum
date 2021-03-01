import 'package:flutter/material.dart';
import 'package:novum/src/blocs/paywall_bloc.dart';
import '../../models/article_model.dart';
import './image_placeholder.dart';
import './fade_route.dart';
import '../screens/article.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;
  final Widget title;
  final Widget thumbnail;
  final Widget published;
  final bool expanded;
  final PaywallBloc bloc = PaywallBloc();

  ArticleTile({
    this.article,
    this.title,
    this.thumbnail,
    this.published,
    this.expanded,
  });

  ArticleTile.fromArticleModel(ArticleModel article, BuildContext context, {bool expanded: false})
      : article = article,
        title = Text(cleanTitle(article.title.split('|')[0]),
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
        thumbnail = article.imageUrl != null
            ? FadeInImage.memoryNetwork(
                image: article.imageUrl,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              )
            : ImagePlaceholder('No image.'),
        published = Text(
          _timestamp(article.published),
          style: Theme.of(context).textTheme.subtitle.copyWith(
                color: Colors.black54,
                fontSize: 14.0,
              ),
        ),
        expanded = expanded;

  Widget build(BuildContext context) {
    Route currentRoute;
    Navigator.popUntil(context, (route) {
      currentRoute = route;
      return true;
    });
    final String category = currentRoute.settings.name != '/search' && currentRoute.settings.name != null
        ? currentRoute.settings.name.replaceAll('/', '')
        : null;
    return InkWell(
      onTap: () {
        bloc.loadArticle(article);
        Navigator.push(context, FadeRoute(Article(article, category: category)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: expanded ? _expandedTile() : _compactTile(),
      ),
    );
  }

  Widget _expandedTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Thumbnail.
        Flexible(
          flex: 3,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(aspectRatio: 4.0 / 3.0, child: Container(color: Colors.black26)),
              AspectRatio(aspectRatio: 4.0 / 3.0, child: thumbnail),
            ],
          ),
        ),

        // Title and timestamp.
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: published),
              title,
            ],
          ),
        ),
      ],
    );
  }

  Widget _compactTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(bottom: 6.0), child: published),
              title,
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(aspectRatio: 1.0 / 1.0, child: Container(color: Colors.black26)),
                AspectRatio(aspectRatio: 1.0 / 1.0, child: thumbnail),
              ],
            ),
          ),
        )
      ],
    );
  }

  static String cleanTitle(String originalTitle) {
    List<String> split = originalTitle.split(' - ');
    return split[0];
  }

  /// Returns the article's published date in a readable
  /// form.
  static String _timestamp(DateTime oldDate) {
    String timestamp;
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(oldDate);
    if (difference.inSeconds < 60) {
      timestamp = 'Ahora';
    } else if (difference.inMinutes < 60) {
      timestamp = 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      timestamp = 'Hace ${difference.inHours} horas';
    } else if (difference.inDays < 30) {
      timestamp = 'Hace ${difference.inDays} días';
    }
    return timestamp;
  }
}
