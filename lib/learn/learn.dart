import 'package:finlearn/learn/level2.dart';
import 'package:finlearn/learn/level1.dart';
import 'package:flutter/material.dart';

import 'level3.dart';

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
            child: Level1(),
          ),
          Center(
            child: Level2(),
          ),
          Center(
            child: Level3(),
          )
        ],
      )),
    );
  }
}
