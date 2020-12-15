import 'package:credit_card_input_form/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/components/yellow_border.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:provider/provider.dart';
import 'card_logo.dart';
import 'card_name.dart';
import 'card_number.dart';
import 'card_valid.dart';

class FrontCardView extends StatelessWidget {
  final height;
  final decoration;
  final cardCompany;
  final obscureNumber;
  final String name;

  final double numberTextSize;
  final double expiryTextSize;
  final double nameTextSize;

  FrontCardView({this.height, this.decoration, this.cardCompany, this.numberTextSize, this.expiryTextSize, this.nameTextSize, this.name, this.obscureNumber = false});

  @override
  Widget build(BuildContext context) {
    final captions = Provider.of<Captions>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: height,
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            YellowBorder(),
            Align(
              alignment: Alignment.centerLeft,
              child: CardNumber(obscured: obscureNumber, fontSize: numberTextSize, name: name),
            ),
            Align(alignment: Alignment.topRight, child: CardLogo(company: cardCompany)),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      captions.getCaption('CARDHOLDER_NAME').toUpperCase(),
                      style: kTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CardName(fontSize: nameTextSize),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      captions.getCaption('VALID_THRU').toUpperCase(),
                      style: kTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CardValid(fontSize: expiryTextSize),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
