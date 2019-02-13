import 'package:flutter/material.dart';
import '../../models/symbol_model.dart';
import '../../models/chart_model.dart';
import '../../blocs/iex_bloc.dart';
import '../screens/stock_settings.dart';
import './stock_data_header.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class IexStockData extends StatelessWidget {

  final bloc = IexBloc();

  @override
  Widget build(BuildContext context) {
    final TextStyle attributionText = Theme.of(context).textTheme.body1.copyWith(
      color: Colors.black54,
    );
    final TextStyle attributionLink = Theme.of(context).textTheme.body1.copyWith(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w500,
    );
    return Container(
      child: Column(
        children: <Widget>[

          StreamBuilder(
            stream: bloc.symbols,
            builder: (BuildContext context, AsyncSnapshot<List<SymbolModel>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    StreamBuilder(
                      stream: bloc.chart,
                      builder: (BuildContext context, AsyncSnapshot<ChartModel> secondSnapshot) {
                        if (secondSnapshot.hasData) {
                          final dateTime = secondSnapshot.data.chart.keys.toList()[0];
                          return Column(
                            children: <Widget>[
                              StockDataHeader(
                                dateTime: dateTime,
                                action: IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) => StockSettings(
                                        bloc: bloc,
                                        symbols: snapshot.data,
                                      ),
                                    ).then((updateSymbols) {
                                      if (updateSymbols != null && updateSymbols) {
                                        bloc.requestSymbols();
                                      }
                                    });
                                    
                                  },
                                ),
                              ),
                              Container(
                                height: 112.0,
                                child: Sparkline(
                                  data: secondSnapshot.data.chart.values.toList(),
                                  lineColor: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          );
                        }
                        bloc.requestChart(snapshot.data[0]);
                        return Container(height: 112.0);
                      },
                    ),
                    Container(
                      height: 124.0,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 3,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 1.0,
                            color: Theme.of(context).dividerColor,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              bloc.requestChart(snapshot.data[index]);
                              bloc.requestSymbols();
                            },
                            child: _DataTile(
                              title: snapshot.data[index].symbol,
                              subtitle: snapshot.data[index].latestPrice.toString(),
                              change: snapshot.data[index].extendedChange,
                              active: snapshot.data[index] == bloc.activeSymbol,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                bloc.requestSymbols();
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          // Include attribution to IEX for providing the data.
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Row(
              children: <Widget>[
                Text('Data provided for free by ', style: attributionText),
                InkWell(
                  onTap: () => _launchUrl(context, 'https://iextrading.com/developer'),
                  child: Text('IEX', style: attributionLink),
                ),
                Text('. View ', style: attributionText),
                InkWell(
                  onTap: () => _launchUrl(context, 'https://iextrading.com/api-exhibit-a/'),
                  child: Text('IEX\'s terms of use', style: attributionLink),
                ),
                Text('.', style: attributionText),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void _launchUrl(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}

class _DataTile extends StatelessWidget {

  _DataTile({
    this.title,
    this.subtitle,
    this.change,
    this.active = false,
  });

  final String title;
  final String subtitle;
  final double change;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Libre Franklin',
              fontWeight: FontWeight.w700,
              color: active ? Theme.of(context).accentColor : Colors.black87,
            ),
          ),

          SizedBox(height: 4.0),

          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Libre Franklin',
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),

          SizedBox(height: 8.0),

          displayChange(context),

        ],
      ),
    );
  }

  Widget displayChange(BuildContext context) {
    bool negative = change.toString().contains('-');
    final Widget symbol = negative
      ? Text('- ', style: Theme.of(context).textTheme.body1.copyWith(
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.w700,
      ))
      : Text('+ ', style: Theme.of(context).textTheme.body1.copyWith(
        color: Colors.greenAccent[400],
        fontWeight: FontWeight.w700,
      ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        symbol,
        Text(
          '${change.toString().replaceAll('-', '')}%',
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }

}