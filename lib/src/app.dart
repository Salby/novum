import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/theme/theme.dart';
import './ui/screens/browse.dart';
import './ui/screens/search.dart';
import './ui/screens/auth.dart';
import 'package:flutter_villains/villain.dart';
import 'package:newsapi_client/newsapi_client.dart';

class NovumApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [VillainTransitionObserver()],
      debugShowCheckedModeBanner: false,
      theme: Themes.light.theme,
      darkTheme: Themes.dark.theme,
      title: 'Novum',
      home: Auth(),
      routes: {
        '/home': (context) => Browse(title: 'Front page'),
        '/search': (context) => Search(),
        '/business': (context) => Browse(title: 'Business', category: Categories.business),
        '/entertainment': (context) => Browse(title: 'Entertainment', category: Categories.entertainment),
        '/health': (context) => Browse(title: 'Health', category: Categories.health),
        '/science': (context) => Browse(title: 'Science', category: Categories.business),
        '/sports': (context) => Browse(title: 'Sports', category: Categories.sports),
        '/technology': (context) => Browse(title: 'Technology', category: Categories.technology),
      },
    );

  }

}