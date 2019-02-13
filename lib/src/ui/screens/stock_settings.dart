import 'package:flutter/material.dart';
import '../../models/symbol_model.dart';
import '../../blocs/iex_bloc.dart';

class StockSettings extends StatelessWidget {

  StockSettings({
    @required this.bloc,
    @required this.symbols,
  });

  final List<SymbolModel> symbols;
  final IexBloc bloc;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 256.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Header.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                'Stocks to follow',
                style: Theme.of(context).textTheme.headline.copyWith(
                  fontFamily: 'Libre Franklin',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Form.
            _Form(formKey: _formKey, bloc: bloc, symbols: symbols),

            // Actions.
            ButtonBar(
              children: <Widget>[

                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  highlightColor: Theme.of(context).accentColor.withOpacity(0.1),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                  child: Text('Close'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                OutlineButton(
                  textColor: Theme.of(context).accentColor,
                  highlightedBorderColor: Theme.of(context).accentColor,
                  highlightElevation: 0.0,
                  highlightColor: Theme.of(context).accentColor.withOpacity(0.1),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.1),
                  child: Text('Save changes'),
                  onPressed: () => _save(context),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(context, true);
    }
  }

}

class _Form extends StatefulWidget {

  _Form({
    @required this.symbols,
    @required this.bloc,
    @required this.formKey,
  });

  final List<SymbolModel> symbols;
  final IexBloc bloc;
  final GlobalKey formKey;

  @override
  _FormState createState() => _FormState();

}

class _FormState extends State<_Form> {

  List<String> _data = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        children: <Widget>[

          SizedBox(width: 16.0),

          Flexible(
            flex: 1,
            child: TextFormField(
              initialValue: widget.symbols[0].symbol.toUpperCase(),
              validator: (value) => validator(value),
              decoration: InputDecoration(
                hintText: 'Symbol 1',
              ),
              textCapitalization: TextCapitalization.characters,
              onSaved: (value) {
                _data.add(value);
              },
            ),
          ),
          
          SizedBox(width: 16.0),

          Flexible(
            flex: 1,
            child: TextFormField(
              initialValue: widget.symbols[1].symbol.toUpperCase(),
              validator: (value) => validator(value),
              decoration: InputDecoration(
                hintText: 'Symbol 2',
              ),
              textCapitalization: TextCapitalization.characters,
              onSaved: (value) {
                _data.add(value);
              },
            ),
          ),

          SizedBox(width: 16.0),

          Flexible(
            flex: 1,
            child: TextFormField(
              initialValue: widget.symbols[2].symbol.toUpperCase(),
              validator: (value) => validator(value),
              decoration: InputDecoration(
                hintText: 'Symbol 3',
              ),
              textCapitalization: TextCapitalization.characters,
              onSaved: (value) async {
                _data.add(value);
                await widget.bloc.setSymbols(_data);
              },
            ),
          ),

          SizedBox(width: 16.0),

        ],
      ),
    );
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Can\'t be empty';
    } else {
      return null;
    }
  }

}