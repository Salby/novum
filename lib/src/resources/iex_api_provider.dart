import 'dart:convert';
import '../models/symbol_model.dart';
import 'package:http/http.dart';

class IexApiProvider {

  final String urlPrefix = 'https://api.iextrading.com/1.0';
  final client = Client();

  Future<List<SymbolModel>> symbols() async {
    final response = await client.get(urlPrefix + '/stock/market/batch?symbols=aapl,fb,goog&types=quote');
    final parsedJson = _handleResponse(response);
    return _handleSymbols(parsedJson);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data.');
    }
  }

  List<SymbolModel> _handleSymbols(Map<String, dynamic> parsedJson) {
    List symbolList;
    parsedJson.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        symbolList.add(SymbolModel.fromJson(value));
      }
    });
    return symbolList;
  }

}