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
      backgroundColor: Color(0xfff392b1),
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
                      'Hi! I am Alice. I am 10 years old and I love eating candies. But I am weak at Maths and counting '
                      'I want to buy candies but counting change is big headache for me. Will you help in doing that? ',
                      style: GoogleFonts.firaSans(
                        textStyle: TextStyle(
                          color: Color(0xff263284),
                          fontSize: 20,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeMaker()),
                          );
                        }),
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
    return Scaffold(
      backgroundColor: Color(0xfff392b1),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xfff392b1)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Get as much money in your piggy bank as possible, by figuring out the correct change.\n\nFigure out how many of each bill or coin that you expect to get back when you pay for something. For example, if something costs \$3.75 and you pay with a five dollar bill, you would expect back one quarter and one dollar bill.If you get the answer correct, the amount of change is added to your piggy bank. If you get the answer wrong, the correct amount of change is subtracted from your piggy bank. The more money you get in your piggy bank, the harder the questions will get.',
                      style: GoogleFonts.firaSans(
                        textStyle: TextStyle(
                          color: Color(0xff263284),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Image(
                  image: AssetImage('images/'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
