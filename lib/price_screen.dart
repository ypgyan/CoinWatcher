import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_display.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> cryptPrices = {};

  String selectedCurrency = 'USD';
  String coin = 'BTC';
  dynamic coinData;

  void updateUI(currency) async {
    CoinData coinData = CoinData();
    Map<String, String> coinsList =
        await coinData.getCoinsDataByCurrency(currency);
    setState(() {
      cryptPrices = coinsList;
    });
  }

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: currenciesList
            .map((item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                ))
            .toList(),
        onChanged: (value) {
          selectedCurrency = value;
          updateUI(value);
        });
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: currenciesList.map((item) => Text(item)).toList(),
    );
  }

  void initState() {
    super.initState();
    updateUI('USD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                CoinDisplay(
                    coin: 'BTC',
                    coinRate: cryptPrices['BTC'],
                    currency: selectedCurrency),
                CoinDisplay(
                    coin: 'ETH',
                    coinRate: cryptPrices['ETH'],
                    currency: selectedCurrency),
                CoinDisplay(
                    coin: 'LTC',
                    coinRate: cryptPrices['LTC'],
                    currency: selectedCurrency),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
