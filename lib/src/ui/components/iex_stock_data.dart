import 'package:flutter/material.dart';
import '../../models/symbol_model.dart';
import '../../blocs/iex_bloc.dart';

class IexStockData extends StatelessWidget {

  final bloc = IexBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          // TODO: Add stock graph widget.

          StreamBuilder(
            stream: bloc.symbols,
            builder: (BuildContext context, AsyncSnapshot<List<SymbolModel>> snapshot) {
              if (snapshot.hasData) {
                return Container(
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
                      return _DataTile(
                        title: snapshot.data[index].symbol,
                        subtitle: snapshot.data[index].latestPrice.toString(),
                        change: snapshot.data[index].extendedChange,
                      );
                    },
                  ),
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

        ],
      ),
    );
  }

}

class _DataTile extends StatelessWidget {

  _DataTile({
    this.title,
    this.subtitle,
    this.change,
    this.displayBorder = false,
  });

  final String title;
  final String subtitle;
  final double change;
  final bool displayBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        border: displayBorder
          ? Border(right: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).dividerColor,
          ))
          : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Libre Franklin',
              fontWeight: FontWeight.w700,
              color: Colors.black87,
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
          '${change.toString()}%',
          style: Theme.of(context).textTheme.body1,
        ),
      ],
    );
  }

}