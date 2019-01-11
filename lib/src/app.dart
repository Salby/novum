import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/theme/theme.dart';
import './ui/screens/home.dart';

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
      debugShowCheckedModeBanner: false,
      theme: kNovumTheme,
      title: 'Novum',

      routes: {
        '/': (context) => Home(),
      },
    );
  }

}