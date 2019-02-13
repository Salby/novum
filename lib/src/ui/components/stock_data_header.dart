import 'package:flutter/material.dart';

class StockDataHeader extends StatelessWidget {

  StockDataHeader({
    @required this.dateTime,
    this.action,
  });

  final DateTime dateTime;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final String date = dateTime.toString().split(' ')[0];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          // Title.
          Row(
            children: <Widget>[
              Text(
                'Stocks',
                style: Theme.of(context).textTheme.headline,
              ),
              Text(
                ' • $date',
                style: Theme.of(context).textTheme.headline.copyWith(
                  fontFamily: 'Libre Franklin',
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          // Settings.
          action,

        ],
      ),
    );
  }

}