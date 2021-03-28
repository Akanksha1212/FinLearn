import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  final int page;

  const Page1({Key key, this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: 16.0),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Grandfather's coin",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Image(
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/grandparents-with-grandchildren-reading-sofa_38747-528.jpg?size=626&ext=jpg'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          "Every month, Julia and her cousins would go for the big family meal at their grandparents' house. They would always wait excitedly for the moment their grandfather would give them a few coins, \"so you can buy yourself something.\" Then all the children would run off to buy chewing gum, lollies, or wine gums. The grandparents, aunts, uncles, and parents commented that, behaving like this, the children would never learn to manage their money. So they proposed a special test, in which the children would have to show, over the course of a year, just what they could manage to get with those few coins.Some of the children thought that they would save their money, but Ruben and Nico, the two smallest kids, paid no attention, and they continued spending it all on sweets."),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
