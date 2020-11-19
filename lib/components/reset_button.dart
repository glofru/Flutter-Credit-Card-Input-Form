import 'package:credit_card_input_form/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetButton extends StatefulWidget {
  final Function onTap;
  final decoration;
  final textStyle;

  ResetButton({this.onTap, this.decoration, this.textStyle});

  @override
  _ResetButtonState createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  var pressed = false;

  @override
  Widget build(BuildContext context) {
    final captions = Provider.of<Captions>(context);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressed = false;
        });
      },
      child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: pressed ? 2 : 8),
          duration: Duration(milliseconds: 100),
          height: 45 - (pressed ? 5.0 : 0.0),
          decoration: widget.decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              Text(captions.getCaption('RESET'), style: widget.textStyle)
            ],
          )),
    );
  }
}
