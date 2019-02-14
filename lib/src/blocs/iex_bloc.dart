import '../resources/repository.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';
import 'package:rxdart/rxdart.dart';

class IexBloc {

  final _repository = Repository();
  final _symbolsFetcher = PublishSubject<List<SymbolModel>>();
  final _chartFetcher = PublishSubject<ChartModel>();
  SymbolModel activeSymbol;

  Observable<List<SymbolModel>> get symbols => _symbolsFetcher.stream;
  Observable<ChartModel> get chart => _chartFetcher.stream;

  requestSymbols() async {
    List<SymbolModel> symbolList = await _repository.iexApiSymbols();
    _symbolsFetcher.sink.add(symbolList);
  }
  requestChart(SymbolModel symbol) async {
    ChartModel chart = await _repository.iexApiChart(symbol);
    _chartFetcher.sink.add(chart);
    activeSymbol = symbol;
  }
  setSymbols(List<String> symbols) async {
    await _repository.sharedPreferencesProvider.setSymbols(symbols: symbols);
  }

  dispose() {
    _symbolsFetcher.close();
    _chartFetcher.close();
  }

}