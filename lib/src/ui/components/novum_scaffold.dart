import 'package:flutter/material.dart';
import '../navigation.dart';

class NovumScaffold extends StatelessWidget {

  NovumScaffold({
    this.title,
    @required this.body,
  }) : assert(body != null);

  final String title;
  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            brightness: Theme.of(context).brightness,
            centerTitle: true,
            floating: true,
            title: _Title(title ?? 'Novum'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, semanticLabel: 'Search'),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  print('Pressed "search"');
                },
              ),
            ],
          ),

          SliverList(delegate: SliverChildListDelegate(body)),

        ],
      ),
    );
  }

}

class _Title extends StatelessWidget {

  _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.display1.copyWith(
        fontSize: 24.0,
      ),
    ); 
  }

}