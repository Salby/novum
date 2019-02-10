import 'package:flutter/material.dart';
import '../../models/symbol_model.dart';
import '../../blocs/iex_bloc.dart';

class IexStockData extends StatelessWidget {

  final bloc = IexBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[

          // TODO: Add stock graph widget.

          StreamBuilder(
            stream: bloc.symbols,
            builder: (BuildContext context, AsyncSnapshot<List<SymbolModel>> snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[



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

        ],
      ),
    );
  }

}