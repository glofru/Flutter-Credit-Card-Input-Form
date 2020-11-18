import 'package:credit_card_input_form/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/provider/card_valid_provider.dart';
import 'package:provider/provider.dart';
import 'package:credit_card_input_form/constants/constanst.dart';

class CardValid extends StatelessWidget {
  const CardValid({this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    String inputCardValid = Provider.of<CardValidProvider>(context).cardValid;

    var defaultCardValid = Provider.of<Captions>(context)
        .getCaption('MM_YY')
        .substring(inputCardValid.length);

    inputCardValid = inputCardValid.replaceAll("/", "");

    TextStyle validTextStyle, defaultValidStyle;

    if (fontSize != null) {
      validTextStyle = kValidtextStyle.copyWith(fontSize: fontSize);
      defaultValidStyle = kDefaultValidTextStyle.copyWith(fontSize: fontSize);
    } else {
      validTextStyle = kValidtextStyle;
      defaultValidStyle = kDefaultValidTextStyle;
    }

    switch (inputCardValid.length) {
      case 3:
        inputCardValid =
            inputCardValid[0] + inputCardValid[1] + '/' + inputCardValid[2];
        break;
      case 4:
        inputCardValid = inputCardValid[0] +
            inputCardValid[1] +
            '/' +
            inputCardValid[2] +
            inputCardValid[3];
        break;
    }

    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          inputCardValid,
          style: validTextStyle,
        ),
        Text(
          defaultCardValid,
          style: defaultValidStyle,
        )
      ],
    ));
  }
}
