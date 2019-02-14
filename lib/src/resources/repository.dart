import './news_api_provider.dart';
import './iex_api_provider.dart';
import './shared_preferences_provider.dart';
import '../models/article_collection_model.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class Repository {

  final newsApiProvider = NewsApiProvider();
  final iexApiProvider = IexApiProvider();
  final sharedPreferencesProvider = SharedPreferencesProvider();

  Future<ArticleCollectionModel> newsApiRequest(Endpoint endpoint) async {
    final response = await newsApiProvider.request(endpoint);
    return response;
  }

  Future<List<SymbolModel>> iexApiSymbols() async {
    final response = await iexApiProvider.symbols();
    return response;
  }
  Future<ChartModel> iexApiChart(SymbolModel symbol) async {
    final response = await iexApiProvider.chart(symbol);
    return response;
  }

}