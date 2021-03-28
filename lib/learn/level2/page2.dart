import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  final int page;

  const Page2({Key key, this.page}) : super(key: key);
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
                const SizedBox(height: 32.0),
                // Image(
                //   image: NetworkImage(
                //       'https://c3352096.ssl.cf0.rackcdn.com/monedas-abuelo.gif'),
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          "Every time, they would show off their sweets in front of the other children, laughing and making fun of their cousins. They made Clara and Joe so angry that these two could no longer stand to keep saving their money. They joined Ruben and Nico in spending whatever they had, as soon as possible, on sweets."),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                    "Monty was a clever boy, and he decided to start managing his money by exchanging it: buying and selling things, or betting it with other children, in card games. Soon he had surprised the whole family. He had accumulated a lot of money for little effort. The way he was going, he would end up almost a rich man. However, Monty was not being very careful, and he got involved in more and more risky deals. A few months later he hadn't a single penny left, after placing a losing bet on a horse race.Alex, on the other hand, had a will of iron. He saved and saved all the money he was given, wanting to win the competition, and at the end of the year he had collected more money than anyone. Even better, with so much money, he managed to buy sweets at a reduced price, so that on the day of the competition he was presented with enough sweets for much more than a year. And even then, he still had enough left over for a toy. He was the clear winner, and the rest of his cousins learnt from him the advantages of knowing how to save and how to wait.There was also Julia. "),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
