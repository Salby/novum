class SymbolModel {

  SymbolModel.fromJson(Map<String, dynamic> parsedJson) :
    symbol = parsedJson['symbol'],
    companyName = parsedJson['companyName'],
    sector = parsedJson['sector'],
    extendedChange = parsedJson['extendedChange'],
    latestPrice = parsedJson['latestPrice'];

  final String symbol;
  final String companyName;
  final String sector;
  final String extendedChange;
  final double latestPrice;

}