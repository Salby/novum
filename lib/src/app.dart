import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/theme/theme.dart';
import './ui/screens/browse.dart';
import 'package:flutter_villains/villain.dart';

final SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.grey[100],
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
);

class NovumApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
    return MaterialApp(
      navigatorObservers: [VillainTransitionObserver()],
      debugShowCheckedModeBanner: false,
      theme: kNovumTheme,
      title: 'Novum',
      routes: {
        '/': (context) => Browse(title: 'Front page'),
        '/business': (context) => Browse(title: 'Business', category: 'business'),
        '/entertainment': (context) => Browse(title: 'Entertainment', category: 'entertainment'),
        '/health': (context) => Browse(title: 'Health', category: 'health'),
        '/science': (context) => Browse(title: 'Science', category: 'science'),
        '/sports': (context) => Browse(title: 'Sports', category: 'sports'),
        '/technology': (context) => Browse(title: 'Technology', category: 'technology'),
      },
    );

  }

}