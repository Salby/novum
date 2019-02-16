import 'dart:async';
import '../resources/repository.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';

class IexBloc {

  final _repository = Repository();

  SymbolModel activeSymbol;

  final StreamController<List<SymbolModel>> symbols = StreamController();
  final StreamController<ChartModel> chart = StreamController();

  requestSymbols() async {
    List<SymbolModel> symbolList = await _repository.iexApiSymbols();
    symbols.sink.add(symbolList);
  }
  requestChart(SymbolModel symbol) async {
    ChartModel _chart = await _repository.iexApiChart(symbol);
    chart.sink.add(_chart);
    activeSymbol = symbol;
  }
  setSymbols(List<String> symbols) async {
    await _repository.sharedPreferencesProvider.setSymbols(symbols: symbols);
  }

  dispose() {
    symbols.close();
    chart.close();
  }

}