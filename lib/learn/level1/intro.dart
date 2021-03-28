import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level1Intro extends StatefulWidget {
  @override
  _Level1IntroState createState() => _Level1IntroState();
}

class _Level1IntroState extends State<Level1Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xfff392b1)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  ' Welcome to Level 1',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(
                      color: Color(0xff263284),
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image(
                  image: AssetImage("images/char2.png"),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Hi! I am Alice. I am 10 years old and I love budying candies. But I am weak at Maths and counting '
                      'I want to buy candies but counting change is big headache for me. Will you help me by doing that for me? ',
                      style: GoogleFonts.firaSans(
                        textStyle: TextStyle(
                          color: Color(0xff263284),
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        elevation: 5,
                        color: Color(0xff263284),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        onPressed: () {}),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        elevation: 5,
                        color: Color(0xff263284),
                        child: Text(
                          'No (Use 10 Fincoins to skip)',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeMaker extends StatefulWidget {
  @override
  _ChangeMakerState createState() => _ChangeMakerState();
}

class _ChangeMakerState extends State<ChangeMaker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
