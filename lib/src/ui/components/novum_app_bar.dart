import 'package:flutter/material.dart';
import './logo.dart';

/// Custom appBar with expanding/collapsing animation controlled
/// from an AnimationController outside the class.
class NovumAppBar extends StatefulWidget {

  NovumAppBar({
    this.title,
    @required this.controller,
    @required this.context,
    this.elevation,
  });

  /// The title of the app bar. This will be hidden in favor of
  /// a compact logo when the app bar is collapsed.
  final String title;
  final AnimationController controller;
  final BuildContext context;
  /// The size of the shadow underneath the app bar material.
  /// Defaults to [4.0].
  final double elevation;

  @override
  NovumAppBarState createState() => NovumAppBarState();

}

class NovumAppBarState extends State<NovumAppBar> with SingleTickerProviderStateMixin {

  Animation<double> opacity;
  Animation<double> opacity2;
  Animation<double> size;
  Animation<BorderRadius> radius;
  double vwidth;

  @override
  void initState() {
    // Use the width of the viewport to animate the app bar.
    vwidth = MediaQuery.of(widget.context).size.width;
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
        curve: Curves.easeOut,
      ),
      reverseCurve: Interval(
        0.0, 0.3,
        curve: Curves.easeIn,
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
        curve: Curves.easeIn,
      ),
      reverseCurve: Interval(
        0.7, 1.0,
        curve: Curves.easeOut,
      ),
    ));

    /// Size animation.
    /// 
    /// This animation is used to animate the width of the appBar
    /// when scrolling up/down.
    size = Tween<double>(
      begin: vwidth,
      end: 112.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(
        0.3, 1.0,
        curve: Curves.fastOutSlowIn,
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
        width: vwidth,
        height: 56.0,
        child: Stack(
          children: <Widget>[

            /// Contains the app bar material and the menu button.
            /// 
            /// Has a cut shape when collapsed.
            Container(
              width: size.value,
              height: 56.0,
              child: Material(
                color: Theme.of(context).primaryColor,
                elevation: widget.elevation ?? 4.0,
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

            /// App logo component.
            /// 
            /// This logo is hidden when the app bar is expanded.
            Opacity(
              opacity: opacity2.value,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 64.0),
                  child: Logo.compact(),
                ),
              ),
            ),

            /// Title component.
            /// 
            /// The title is hidden when the app bar is collapsed.
            Opacity(
              opacity: opacity.value,
              child: Align(
                alignment: Alignment.center,
                child: Logo.full(title: widget.title),
              ),
            ),

            /// Search button.
            /// 
            /// This button is hidden when the app bar is collapsed.
            Opacity(
              opacity: opacity.value,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.0),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => Navigator.pushNamed(context, '/search'),
                      ),
                    ),
                  ),
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