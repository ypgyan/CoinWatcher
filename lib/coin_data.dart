import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '27AF4F4B-6216-4658-87F8-8120C4B4D9A7';

const url = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData(String currency, String coin) async {
    http.Response res = await http.get(
      '$url/$coin/$currency',
      headers: {'X-CoinAPI-Key': apiKey},
    );
    var body = jsonDecode(res.body);
    return body;
  }

  Future getCoinsDataByCurrency(String currency) async {
    Map<String, String> coinsData = {};
    for (String coin in cryptoList) {
      http.Response res = await http.get(
        '$url/$coin/$currency',
        headers: {'X-CoinAPI-Key': apiKey},
      );
      dynamic response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        double rate = response['rate'];
        coinsData[coin] = rate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return coinsData;
  }
}
