import './symbol_model.dart';

class ChartModel {

  ChartModel.fromJson(SymbolModel symbolModel, Map<String, dynamic> parsedJson) :
    symbol = symbolModel,
    chart = _buildChart(parsedJson);

  final SymbolModel symbol;
  final Map<DateTime, double> chart;

  static Map<DateTime, double> _buildChart(Map<String, dynamic> parsedJson) {
    Map<DateTime, double> chart = {};
    for (Map<String, dynamic> json in parsedJson.values) {
      /// Get date and time from [json].
      final String year = json['date'].toString().substring(0, 4);
      final String month = json['date'].toString().substring(4, 6);
      final String day = json['date'].toString().substring(6);
      final String time = json['minute'].toString() + ':00';

      /// Merge date and time information into a [DateTime] object.
      final dateTime = DateTime.parse('$year-$month-$day $time');

      /// Add key-value pair to [chart].
      chart[dateTime] = json['marketAverage'];
    }
    return chart;
  }

}