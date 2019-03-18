import 'dart:async';
import 'dart:convert';
import './shared_preferences_provider.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';
import 'package:http/http.dart';

class IexApiProvider {

  final String urlPrefix = 'https://api.iextrading.com/1.0';
  final client = Client();
  final sharedPreferencesProvider = SharedPreferencesProvider();

  /// Returns a list of [SymbolModel]s from the three
  /// symbols stored in shared preferences.
  Future<List<SymbolModel>> symbols() async {
    List<String> symbols = await sharedPreferencesProvider.getSymbols();
    if (symbols == null) {
      await sharedPreferencesProvider.setSymbols();
      symbols = await sharedPreferencesProvider.getSymbols();
    }
    final response = await client.get(urlPrefix + '/stock/market/batch?symbols=${symbols[0]},${symbols[1]},${symbols[2]}&types=quote');
    final Map<String, dynamic> parsedJson = _handleResponse(response);
    List<SymbolModel> symbolList = [];
    for (Map<String, dynamic> value in parsedJson.values) {
      symbolList.add(SymbolModel.fromJson(value['quote']));
    }
    return symbolList;
  }

  /// Returns the current [ChartModel] of a [SymbolModel].
  Future<ChartModel> chart(SymbolModel symbol) async {
    final response = await client.get(urlPrefix + '/stock/${symbol.symbol}/chart/');
    List<dynamic> parsedJson = json.decode(response.body);
    return ChartModel.fromJson(symbol, parsedJson);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data.');
    }
  }

}