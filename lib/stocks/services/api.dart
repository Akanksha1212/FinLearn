import 'package:dio/dio.dart';
import 'package:finlearn/stocks/models/mostActiveStocks.dart';

class StockServices {
  static Future<List<MostActiveStocks>> getMostActiveStokcs() async {
    final response = await Dio().get(
        'https://financialmodelingprep.com/api/v3/actives?apikey=bd28f350f3c185cea376bede90e67f12');
    print(response.data[1]);
    return MostActiveStocksList.fromJson(response.data).stocks;
  }

  static Future<List<MostActiveStocks>> getTopGainer() async {
    final response = await Dio().get(
        'https://financialmodelingprep.com/api/v3/gainers?apikey=bd28f350f3c185cea376bede90e67f12');
    print(response.data[1]);
    return MostActiveStocksList.fromJson(response.data).stocks;
  }

  static Future<List<MostActiveStocks>> getTopLosers() async {
    final response = await Dio().get(
        'https://financialmodelingprep.com/api/v3/losers?apikey=bd28f350f3c185cea376bede90e67f12');
    print(response.data[1]);
    return MostActiveStocksList.fromJson(response.data).stocks;
  }
}
