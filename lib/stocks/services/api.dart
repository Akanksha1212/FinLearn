import 'package:dio/dio.dart';

class StockServices {
  static Future getMostActiveStokcs() async {
    final response = await Dio().get(
        'https://financialmodelingprep.com/api/v3/actives?apikey=bd28f350f3c185cea376bede90e67f12');
    print(response.data);
  }
}
