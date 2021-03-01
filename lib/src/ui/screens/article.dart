import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:handcash_connect_sdk/handcash_connect_sdk.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:novum/src/blocs/paywall_bloc.dart';
import 'package:flutter_villains/villain.dart';
import 'package:novum/src/models/article_model.dart';
import 'package:novum/src/ui/components/article_tile.dart';
import 'package:novum/src/ui/components/image_placeholder.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Article extends StatelessWidget {
  Article(this.article, {this.category}) : assert(article != null);

  final ArticleModel article;
  final String category;
  final PaywallBloc bloc = PaywallBloc();

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
  _Content(
    this.article, {
    this.category,
  }) : assert(article != null);

  final ScrollController _scrollController = ScrollController();
  final ArticleModel article;
  final String category;
  final PaywallBloc bloc = PaywallBloc();

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            article.source != null ? 'Fuente: ${article.source}' : 'Error: No es posible identificar la fuente.',
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
          ),
          TextButton(
            onPressed: () {
              _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
            },
            child: Text('Compartir'),
          ),
        ],
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

  List<Widget> _createChildren(ArticleModel article, BuildContext context) {
    final List<String> processedArticle = article.content.split('\n');
    return List<Widget>.generate(processedArticle.length, (int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              processedArticle[index].toString(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16, height: 1.8),
              textAlign: TextAlign.left,
            ),
          );
        }) +
        [_buildShareArea(context)];
  }

  Widget preview(BuildContext context) {
    if (article.content != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: CubitBuilder(
          cubit: bloc,
          builder: (context, state) {
            final bool isUnlocked = state is PaywallStateUnlocked;
            return Column(
              children: isUnlocked
                  ? _createChildren(article, context)
                  : [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16, height: 1.5),
                          children: [
                            TextSpan(text: isUnlocked ? article.content : article.content.substring(0, 400)),
                            isUnlocked
                                ? TextSpan(text: '')
                                : TextSpan(
                                    text: ' ... Puedes leer el resto del artículo por 5 céntimos.',
                                    style: TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      _buildShareArea(context),
                    ],
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildShareArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '¡Comparte el artículo!',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Te damos el 10% de las ventas desde tu enlace:',
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 0),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(MdiIcons.twitter), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.facebook), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.whatsapp), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.instagram), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.snapchat), onPressed: () {}),
            ],
          ),
          Chip(
            backgroundColor: Colors.black.withOpacity(0.06),
            label: Text('news.app/k3JmveIJGs'),
          ),
        ],
      ),
    );
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
    final String title = article.title != null ? ArticleTile.cleanTitle(article.title.split('|')[0]) : '(No title)';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline.copyWith(
              height: 1.0,
            ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final String url;
  final PaywallBloc bloc = PaywallBloc();

  _BottomSheet({
    @required this.url,
  }) : assert(url != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00FFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: SafeArea(
                child: CubitBuilder(
                  cubit: bloc,
                  builder: (context, state) {
                    final bool isNotAuthenticated = state is PaywallStateUnauthenticated;
                    if (isNotAuthenticated) {
                      return _buildConnectWidget(context);
                    } else {
                      return _buildPaywallWidget(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaywallWidget(BuildContext context) {
    return CubitBuilder(
      cubit: bloc,
      builder: (context, state) {
        final bool isPayToUnlock = state is PaywallStatePayToUnlock;
        final bool isUnlocking = state is PaywallStateUnlocking;
        final bool isUnlocked = state is PaywallStateUnlocked;
        if (isPayToUnlock) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent.shade400)),
              child: Padding(padding: EdgeInsets.all(24), child: Text('Leer artículo · €0.05')),
              onPressed: () => bloc.payToUnlock(),
            ),
          );
        } else if (isUnlocking) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent.shade700)),
              child: Padding(padding: EdgeInsets.all(24), child: Text('Pagando...')),
              onPressed: () => bloc.payToUnlock(),
            ),
          );
        } else {
          return SizedBox(
            width: 0,
            height: 0,
          );
        }
      },
    );
  }

  Widget _buildConnectWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('¡Se acabaron las suscripciones!', style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 4),
        Text('Artículos premium desde 1 céntimo. Sin banners, publicidad, ni ataduras.',
            style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(height: 24),
        ConnectButton(),
        const SizedBox(height: 32),
      ],
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
