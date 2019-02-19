import 'package:flutter/material.dart';
import '../../models/chart_model.dart';

class StockDataHeader extends StatelessWidget {

  StockDataHeader({
    @required this.chart,
    this.action,
  });

  final ChartModel chart;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          // Title.
          Row(
            children: <Widget>[
              Text(
                'Stocks ',
                style: Theme.of(context).textTheme.headline,
              ),
              Text(
                '• ${chart.from} - ${chart.to}',
                style: Theme.of(context).textTheme.headline.copyWith(
                  fontFamily: 'Libre Franklin',
                  fontSize: 18.0,
                  color: Colors.black54,
                  height: 0.8,
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