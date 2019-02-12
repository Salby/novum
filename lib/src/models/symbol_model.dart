class SymbolModel {

  SymbolModel.fromJson(Map<String, dynamic> parsedJson) :
    symbol = parsedJson['symbol'],
    companyName = parsedJson['companyName'],
    sector = parsedJson['sector'],
    extendedChange = _parseChange(parsedJson['extendedChange']),
    latestPrice = parsedJson['latestPrice'];

  final String symbol;
  final String companyName;
  final String sector;
  final double extendedChange;
  final double latestPrice;

  static double _parseChange(dynamic number) {
    if (number is int) {
      return number.toDouble();
    } else {
      return number;
    }
  }

}