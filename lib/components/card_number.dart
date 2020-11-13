import 'package:flutter/material.dart';
import 'package:credit_card_input_form/provider/card_number_provider.dart';
import 'package:provider/provider.dart';

import 'package:credit_card_input_form/constants/constanst.dart';

class CardNumber extends StatelessWidget {
  const CardNumber({this.obscured = false});

  final bool obscured;

  @override
  Widget build(BuildContext context) {
    String cardNumber =
        Provider.of<CardNumberProvider>(context, listen: true).cardNumber;
    String defaultNumber = '';
    final texts = <Widget>[];

    if (obscured) {
      defaultNumber = "**** **** **** ";
      cardNumber = cardNumber.substring(cardNumber.length-4, cardNumber.length);

      texts.add(Text(defaultNumber, style: kCardDefaultTextStyle));
      texts.add(Text(cardNumber, style: kCardNumberTextStyle));
    } else {
      final numberLength = cardNumber.replaceAll(" ", "").length;

      for (int i = 1; i <= 16 - numberLength; i++) {
        defaultNumber = 'X' + defaultNumber;
        if (i % 4 == 0 && i != 16) {
          defaultNumber = ' ' + defaultNumber;
        }
      }

      texts.add(Text(cardNumber, style: kCardNumberTextStyle));
      texts.add(Text(defaultNumber, style: kCardDefaultTextStyle));
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: texts
          ),
        ),
      ),
    );
  }
}
