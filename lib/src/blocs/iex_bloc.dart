import '../resources/repositoy.dart';
import '../models/symbol_model.dart';
import 'package:rxdart/rxdart.dart';

class IexBloc {

  final _repository = Repository();
  final _symbolsFetcher = PublishSubject<List<SymbolModel>>();

  Observable<List<SymbolModel>> get symbols => _symbolsFetcher.stream;

  requestSymbols() async {
    List<SymbolModel> symbolList = await _repository.iexApiSymbols();
    _symbolsFetcher.sink.add(symbolList);
  }

  dispose() {
    _symbolsFetcher.close();
  }

}