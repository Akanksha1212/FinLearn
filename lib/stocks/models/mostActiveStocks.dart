import 'dart:convert';

import 'package:flutter/material.dart';

class MostActiveStocks {
  final String ticker;
  final String price;
  final double changes;
  final String changesPercentage;
  final String companyName;
  MostActiveStocks({
    @required this.ticker,
    @required this.price,
    @required this.changes,
    @required this.changesPercentage,
    @required this.companyName,
  });

  MostActiveStocks copyWith({
    String ticker,
    String price,
    double changes,
    String changesPercentage,
    String companyName,
  }) {
    return MostActiveStocks(
      ticker: ticker ?? this.ticker,
      price: price ?? this.price,
      changes: changes ?? this.changes,
      changesPercentage: changesPercentage ?? this.changesPercentage,
      companyName: companyName ?? this.companyName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ticker': ticker,
      'price': price,
      'changes': changes,
      'changesPercentage': changesPercentage,
      'companyName': companyName,
    };
  }

  factory MostActiveStocks.fromMap(Map<String, dynamic> map) {
    return MostActiveStocks(
      ticker: map['ticker'],
      price: map['price'],
      changes: map['changes'],
      changesPercentage: map['changesPercentage'],
      companyName: map['companyName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MostActiveStocks.fromJson(String source) =>
      MostActiveStocks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MostActiveStocks(ticker: $ticker, price: $price, changes: $changes, changesPercentage: $changesPercentage, companyName: $companyName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MostActiveStocks &&
        other.ticker == ticker &&
        other.price == price &&
        other.changes == changes &&
        other.changesPercentage == changesPercentage &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return ticker.hashCode ^
        price.hashCode ^
        changes.hashCode ^
        changesPercentage.hashCode ^
        companyName.hashCode;
  }
}

class MostActiveStocksList {
  final List<MostActiveStocks> stocks;

  MostActiveStocksList({
    this.stocks,
  });

  factory MostActiveStocksList.fromJson(List<dynamic> parsedJson) {
    List<MostActiveStocks> stocks = [];
    stocks = parsedJson.map((i) => MostActiveStocks.fromMap(i)).toList();

    return MostActiveStocksList(stocks: stocks);
  }
}
