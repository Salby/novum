import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: SafeArea(
        child: Column(
          children: <Widget>[

            // Header with logo and close button.
            DrawerHeader(),

            // Drawer navigatio  items.
            DrawerItem(title: 'Front page', route: '/'),
            DrawerItem(title: 'Business', route: '/business'),
            DrawerItem(title: 'Entertainment', route: '/entertainment'),
            DrawerItem(title: 'Health', route: '/health'),
            DrawerItem(title: 'Science', route: '/science'),
            DrawerItem(title: 'Sports', route: '/sports'),
            DrawerItem(title: 'Technology', route: '/technology'),

            Spacer(),

            ListTile(
              contentPadding: EdgeInsets.only(left: 34.0),
              title: Row(
                children: <Widget>[
                  Text('Powered by ', style: TextStyle(
                    fontFamily: 'Libre Franklin',
                    fontSize: 14.0,
                    height: 0.8,
                    color: Colors.black54,
                  )),
                  Text('NewsApi.org', style: TextStyle(
                    fontFamily: 'Eczar',
                    fontSize: 14.0,
                  )),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

}

class DrawerHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 20.0, left: 16.0),
      title: Text('Novum', style: Theme.of(context).textTheme.display1),
      leading: IconButton(
        color: Colors.black87,
        icon: Icon(Icons.close, semanticLabel: 'Close'),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Close',
      ),
    );
  }

}

class DrawerItem extends StatelessWidget {

  DrawerItem({
    @required this.title,
    @required this.route,
  }) : assert(title != null),
       assert(route != null);

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    bool currentRoute;
    Navigator.popUntil(context, (route) {
      currentRoute = route.settings.name == this.route;
      return true;
    });
    return ListTile(
      enabled: !currentRoute,
      contentPadding: EdgeInsets.only(left: 34.0, right: 34.0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle.copyWith(
          color: currentRoute
            ? Colors.black54
            : Colors.black87,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: currentRoute
        ? Icon(
          Icons.fiber_manual_record,
          color: Colors.black38,
          size: 12.0,
        )
        : null,
      onTap: () => Navigator.of(context).pushReplacementNamed(route),
    );
  }

}