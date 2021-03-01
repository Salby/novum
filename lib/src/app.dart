import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/theme/theme.dart';
import './ui/screens/browse.dart';
import './ui/screens/search.dart';
import './ui/screens/auth.dart';
import 'package:flutter_villains/villain.dart';
import 'package:newsapi_client/newsapi_client.dart';

final SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.white,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.white,
);

class NovumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
    return MaterialApp(
      navigatorObservers: [VillainTransitionObserver()],
      debugShowCheckedModeBanner: false,
      theme: kNovumTheme,
      title: 'News App',
      home: Browse(title: 'Titulares'),
      routes: {
        '/home': (context) => Browse(title: 'Titulares'),
        '/search': (context) => Search(),
        '/business': (context) => Browse(title: 'Negocios', category: Categories.business),
        '/entertainment': (context) => Browse(title: 'Entretenimiento', category: Categories.entertainment),
        '/health': (context) => Browse(title: 'Salud', category: Categories.health),
        '/science': (context) => Browse(title: 'Ciencia', category: Categories.business),
        '/sports': (context) => Browse(title: 'Deportes', category: Categories.sports),
        '/technology': (context) => Browse(title: 'Tecnología', category: Categories.technology),
      },
    );
  }
}
