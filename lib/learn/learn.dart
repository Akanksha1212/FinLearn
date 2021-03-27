import 'package:finlearn/learn/investment.dart';
import 'package:finlearn/learn/loans.dart';
import 'package:flutter/material.dart';

class LearnHome extends StatefulWidget {
  @override
  _LearnHomeState createState() => _LearnHomeState();
}

class _LearnHomeState extends State<LearnHome> {
  @override
  final PageController controller = PageController(initialPage: 0);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: <Widget>[
          Center(
            child: Loans(),
          ),
          Center(
            child: Investment(),
          ),
          Center(
            child: Loans(),
          )
        ],
      )),
    );
  }
}
