import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import './image_placeholder.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleTile extends StatelessWidget {

  ArticleTile({
    this.title,
    this.thumbnail,
    this.published,
    this.expanded,
  });

  ArticleTile.fromArticleModel(ArticleModel article, BuildContext context, {bool expanded: false}) :
    title = Text(_cleanTitle(article.title), style: Theme.of(context).textTheme.body1.copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    )),
    thumbnail = article.imageUrl != null
      //? Image.network(article.imageUrl, fit: BoxFit.cover)
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

  final Widget title;
  final Widget thumbnail;
  final Widget published;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: expanded ? _expandedTile() : _compactTile(),
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

              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: published
              ),

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

              Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: published
              ),

              title,

            ],
          ),
        ),

        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
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

  static String _cleanTitle(String originalTitle) {
    List<String> split = originalTitle.split(' - ');
    return split[0];
  }

  static String _timestamp(DateTime oldDate) {
    String timestamp;
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(oldDate);
    if (difference.inSeconds < 60) {
      timestamp = 'Now';
    } else if (difference.inMinutes < 60) {
      timestamp = '${difference.inMinutes}M';
    } else if (difference.inHours < 24) {
      timestamp = '${difference.inHours}H';
    } else if (difference.inDays < 30) {
      timestamp = '${difference.inDays}D';
    }
    return timestamp;
  }

}