import 'package:finlearn/learn/level2/page.dart';
import 'package:finlearn/learn/level2/page2.dart';
import 'package:finlearn/learn/level2/page3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_turn/page_turn.dart';
export 'page.dart';

class Level2Intro extends StatefulWidget {
  const Level2Intro({
    Key key,
  }) : super(key: key);

  @override
  _Level2IntroState createState() => _Level2IntroState();
}

class _Level2IntroState extends State<Level2Intro> {
  final _controller = GlobalKey<PageTurnState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTurn(
        key: _controller,
        backgroundColor: Colors.white,
        showDragCutoff: false,
        lastPage: Container(
            child: Center(
                child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Image(
                image: NetworkImage(
                    'https://media1.giphy.com/media/YrfkO0w8IdrDpdReRA/giphy.gif'),
              ),
              Text(
                ' A little money well spent can achieve a lot more than we had imagined, especially if it helps us to learn and develop ourselves.',
                style: GoogleFonts.firaSans(
                  textStyle: TextStyle(
                    color: Color(0xff263284),
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                '\n\nThe End',
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: Color(0xff263284),
                    fontSize: 47,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ))),
        children: <Widget>[
          Page1(),
          Page2(),
          Page3(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          _controller.currentState.goToPage(3);
        },
      ),
    );
  }
}
