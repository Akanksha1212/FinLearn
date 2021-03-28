import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/learn/learn.dart';
import 'package:finlearn/pages/child/child_goals.dart';
import 'package:finlearn/pages/child/child_home.dart';

import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _widgetOptions = <Widget>[
    ChildHome(),
    LearnHome(),
    ChildGoal(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBluePurple,
      body: _widgetOptions[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,

        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xff263284),
        // animationDuration: Duration(seconds: 1),
        // animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 20,
            color: Color(0xff263284),
          ),
          Icon(
            Icons.money,
            size: 20,
            color: Color(0xff263284),
          ),
          Icon(
            Icons.book_outlined,
            size: 20,
            color: Color(0xff263284),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
