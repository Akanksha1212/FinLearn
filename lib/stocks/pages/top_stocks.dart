import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/stocks/models/mostActiveStocks.dart';
import 'package:finlearn/stocks/services/api.dart';

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBluePurple,
          title: Text("Stocks"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: kBluePurple ?? Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                StockHeader(
                  title: "Most Active Stocks",
                ),
                StockList(
                  future: StockServices.getMostActiveStokcs(),
                ),
                StockHeader(
                  title: "Top Gainers",
                ),
                StockList(
                  future: StockServices.getTopGainer(),
                ),
                StockHeader(
                  title: "Top Losers",
                ),
                StockList(
                  future: StockServices.getTopLosers(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StockHeader extends StatelessWidget {
  final String title;
  const StockHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
        child: Text(
          title ?? "Most Active Stocks",
          style: GoogleFonts.playfairDisplay(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class StockList extends StatelessWidget {
  final Future<dynamic> future;
  const StockList({
    Key key,
    @required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    MostActiveStocks stock =
                        snapshot.data[index] as MostActiveStocks;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Container(
                          height: 20,
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 15,
                                ),
                                child: Text(
                                  stock.ticker,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  stock.companyName,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: Text("Trade"),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10,
                                ),
                                child: Text(
                                  stock.price + " " + stock.changesPercentage,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: stock.changes > 0
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
