import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {

  ImagePlaceholder(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).accentColor.withOpacity(0.3),
          ],
        ),
      ),
      child: Text(text, style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      )),
    );
  }

}