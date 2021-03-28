import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  final int page;

  const Page3({Key key, this.page}) : super(key: key);
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
                          "Poor Julia didn\'t enjoy the day of the competition, because even though she had had a wonderful secret plan, she had spent her money without giving her plan enough time to work. However, she was so sure that her plan was a good one, that she decided to carry on with it, and maybe change the expressions on her relatives\' faces, who had seemed to be saying \"What a disaster that girl is. She couldn\'t manage to save anything.\"When she was about to complete the second year of her plan, Julia surprised everyone by turning up at the grandparents\' house with a violin and a lot of money. What was even more impressive was hearing her play. She did it really well. Everyone knew that Julia adored the violin, even though the family couldn\'t afford to pay for her to have lessons. So Julia had got to know a poor violinist who played in the park, and she offered him all the coins her grandfather had given her, if he would teach her how to play. Although it wasn\'t much money, on seeing Julia\'s excitement, the violinist agreed, and he taught her happily for months. Julia showed so much desire and interest that a little after a year the violinist loaned her a violin so they could play together in the park, as a duo. They were so successful that gradually she managed to buy her own violin, with quite a bit of money to spare.From then on, the whole family helped her, and she became a very famous violinist. And she would always tell people how it was possible, with just a few coins well spent, to make your wildest dreams a reality."),
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
