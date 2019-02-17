import 'dart:async';
import '../resources/repository.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';

class IexBloc {

  final _repository = Repository();

  SymbolModel activeSymbol;

  final StreamController<List<SymbolModel>> _symbols = StreamController();
  final StreamController<ChartModel> _chart = StreamController();

  Stream<List<SymbolModel>> get symbols => _symbols.stream;
  Stream<ChartModel> get chart => _chart.stream;

  requestSymbols() async {
    List<SymbolModel> symbolList = await _repository.iexApiSymbols();
    _symbols.sink.add(symbolList);
  }
  requestChart(SymbolModel symbol) async {
    ChartModel chart = await _repository.iexApiChart(symbol);
    _chart.sink.add(chart);
    activeSymbol = symbol;
  }
  setSymbols(List<String> symbols) async {
    await _repository.sharedPreferencesProvider.setSymbols(symbols: symbols);
  }

  dispose() {
    _symbols.close();
    _chart.close();
  }

}