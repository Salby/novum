import 'package:flutter/material.dart';
import '../navigation.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Novum',
          style: Theme.of(context).textTheme.display1.copyWith(
            fontSize: 24.0,
          ),
        ),
        actions: <Widget>[
          // Search button.
          IconButton(
            icon: Icon(Icons.search, semanticLabel: 'Search'),
            onPressed: () {
              print('Pressed \'search\'');
            },
            tooltip: 'Search',
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

}