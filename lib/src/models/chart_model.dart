import './symbol_model.dart';

class ChartModel {

  ChartModel({
    this.symbol,
    this.chart,
    this.from,
    this.to,
  });

  ChartModel.fromJson(SymbolModel symbolModel, List<dynamic> parsedJson) :
    symbol = symbolModel,
    chart = _buildChart(parsedJson),
    from = parsedJson[0]['label'],
    to = parsedJson[parsedJson.length - 1]['label'];

  final SymbolModel symbol;
  final Map<DateTime, double> chart;
  final String from;
  final String to;

  static Map<DateTime, double> _buildChart(List<dynamic> parsedJson) {
    Map<DateTime, double> chart = {};
    for (Map<String, dynamic> json in parsedJson) {

      /// Merge date and time information into a [DateTime] object.
      final dateTime = DateTime.parse(json['date']);

      if (json['volume'] is String) {
        json['volume'] = double.tryParse(json['volume']);
      } else if (json['volume'] is int) {
        json['volume'] = json['volume'].toDouble();
      }

      /// Add key-value pair to [chart].
      chart[dateTime] = json['volume'];
    }
    return chart;
  }

}