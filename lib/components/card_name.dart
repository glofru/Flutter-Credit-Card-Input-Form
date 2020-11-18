import 'package:credit_card_input_form/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/provider/card_name_provider.dart';
import 'package:provider/provider.dart';

class CardName extends StatelessWidget {
  const CardName({this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final defaultName =
        Provider.of<Captions>(context).getCaption('NAME_SURNAME').toUpperCase();
    final String name =
        Provider.of<CardNameProvider>(context).cardName.toUpperCase();

    TextStyle defaultNameStyle, emptyTextStyle;

    if (fontSize != null) {
      defaultNameStyle = kDefaultNameTextStyle.copyWith(fontSize: fontSize);
      emptyTextStyle = kNametextStyle.copyWith(fontSize: fontSize);
    } else {
      defaultNameStyle = kDefaultNameTextStyle;
      emptyTextStyle = kNametextStyle;
    }

    return Text(name.isNotEmpty ? name : defaultName,
        style: name.isNotEmpty ? emptyTextStyle : defaultNameStyle);
  }
}
