import 'package:flutter/material.dart';

class NovumAppBar extends StatefulWidget {

  NovumAppBar({
    this.title,
    @required this.controller,
    @required this.context,
  }) : viewportWidth = MediaQuery.of(context).size.width;

  final String title;
  final AnimationController controller;
  final BuildContext context;
  final double viewportWidth;

  @override
  NovumAppBarState createState() => NovumAppBarState();

}

class NovumAppBarState extends State<NovumAppBar> with SingleTickerProviderStateMixin {

  Animation<double> opacity;
  Animation<double> opacity2;
  Animation<double> size;
  Animation<BorderRadius> radius;

  @override
  void initState() {
    super.initState();
    /// First opacity animation.
    /// 
    /// This animation is used to animate the opacity of
    /// the full-width-only widgets, like the full title
    /// and search button.
    opacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.0, 0.3,
        curve: Curves.easeIn,
      ),
      reverseCurve: Interval(
        0.0, 0.3,
        curve: Curves.easeOut,
      ),
    ));
    /// Second opacity animation.
    /// 
    /// This animation is used to animate the opacity of
    /// the compact-only widgets, like the small app logo.
    opacity2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.7, 1.0,
        curve: Curves.easeOut,
      ),
      reverseCurve: Interval(
        0.7, 1.0,
        curve: Curves.easeIn,
      ),
    ));
    /// Size animation.
    /// 
    /// This animation is used to animate the width of the appBar
    /// when scrolling up/down.
    size = Tween<double>(
      begin: widget.viewportWidth,
      end: 112.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.3, 1.0,
        curve: Curves.easeInOut,
      ),
    ));
    /// Radius animation.
    /// 
    /// This animation is used to animate the size of the cut
    /// in the bottom left corner of the appBar.
    radius = BorderRadiusTween(
      begin: BorderRadius.only(bottomRight: Radius.circular(0.0)),
      end: BorderRadius.only(bottomRight: Radius.circular(16.0)),
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.3, 1.0,
        curve: Curves.easeInOut,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: widget.viewportWidth,
        height: 56.0,
        child: Stack(
          children: <Widget>[

            Container(
              width: size.value,
              height: 56.0,
              child: Material(
                color: Theme.of(context).primaryColor,
                elevation: 4.0,
                shape: BeveledRectangleBorder(
                  borderRadius: radius.value,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 4.0),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ],
                ),
              ),
            ),

            // App logo component.
            Opacity(
              opacity: opacity2.value,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 64.0),
                  child: Text('N', style: Theme.of(context).textTheme.display1.copyWith(
                    fontSize: 26.0,
                    height: 1.2,
                  )),
                ),
              ),
            ),

            // Title component.
            Opacity(
              opacity: opacity.value,
              child: Align(
                alignment: Alignment.center,
                child: _Title(widget.title),
              ),
            ),

            // Search button.
            Opacity(
              opacity: opacity.value,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('You tapped the search button!'),
                      duration: Duration(milliseconds: 1500),
                    ));
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
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