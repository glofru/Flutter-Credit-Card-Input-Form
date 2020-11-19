import 'package:credit_card_input_form/components/reset_button.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:credit_card_input_form/components/back_card_view.dart';
import 'package:credit_card_input_form/components/front_card_view.dart';
import 'package:credit_card_input_form/components/input_view_pager.dart';
import 'package:credit_card_input_form/components/round_button.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:credit_card_input_form/provider/card_cvv_provider.dart';
import 'package:credit_card_input_form/provider/card_name_provider.dart';
import 'package:credit_card_input_form/provider/card_number_provider.dart';
import 'package:credit_card_input_form/provider/card_valid_provider.dart';
import 'package:credit_card_input_form/provider/state_provider.dart';
import 'package:provider/provider.dart';

import 'constants/captions.dart';
import 'constants/constanst.dart';

typedef CardInfoCallback = void Function(
    InputState currentState, CardInfo cardInfo);

class CreditCardInputForm extends StatelessWidget {
  CreditCardInputForm(
      {Key key,
      this.onStateChange,
      this.cardHeight,
      this.frontCardDecoration,
      this.backCardDecoration,
      this.showResetButton = true,
      this.showOnlyCard = false,
      this.obscureNumber = false,
      this.numberTextSize,
      this.expiryTextSize,
      this.nameTextSize,
      this.cardCompany,
      this.validationEnabled = true,
      this.onNumberInvalid,
      this.onValidationInvalid,
      this.onNameInvalid,
      this.onCvvInvalid,
      this.customCaptions,
      this.cardNumber = '',
      this.cardName = '',
      this.cardCVV = '',
      this.cardValid = '',
      this.intialCardState = InputState.NUMBER,
      this.nextButtonTextStyle = kDefaultButtonTextStyle,
      this.prevButtonTextStyle = kDefaultButtonTextStyle,
      this.resetButtonTextStyle = kDefaultButtonTextStyle,
      this.nextButtonDecoration = defaultNextPrevButtonDecoration,
      this.prevButtonDecoration = defaultNextPrevButtonDecoration,
      this.resetButtonDecoration = defaultResetButtonDecoration}) : super(key: key);

  final Function onStateChange;
  final double cardHeight;
  final BoxDecoration frontCardDecoration;
  final BoxDecoration backCardDecoration;
  final bool showResetButton;
  final bool showOnlyCard;
  final bool obscureNumber;
  final double numberTextSize;
  final double expiryTextSize;
  final double nameTextSize;
  final String cardCompany;
  final bool validationEnabled;
  final Function(BuildContext) onNumberInvalid;
  final Function(BuildContext) onValidationInvalid;
  final Function(BuildContext) onNameInvalid;
  final Function(BuildContext) onCvvInvalid;
  final Map<String, String> customCaptions;
  final BoxDecoration nextButtonDecoration;
  final BoxDecoration prevButtonDecoration;
  final BoxDecoration resetButtonDecoration;
  final TextStyle nextButtonTextStyle;
  final TextStyle prevButtonTextStyle;
  final TextStyle resetButtonTextStyle;
  final String cardNumber;
  final String cardName;
  final String cardCVV;
  final String cardValid;
  final InputState intialCardState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateProvider(intialCardState),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNumberProvider(cardNumber),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNameProvider(cardName),
        ),
        ChangeNotifierProvider(
          create: (context) => CardValidProvider(cardValid),
        ),
        ChangeNotifierProvider(
          create: (context) => CardCVVProvider(cardCVV),
        ),
        Provider(
          create: (_) => Captions(customCaptions: customCaptions),
        ),
      ],
      child: CreditCardInputImpl(
        onCardModelChanged: onStateChange,
        backDecoration: backCardDecoration,
        frontDecoration: frontCardDecoration,
        cardHeight: cardHeight,
        showResetButton: showResetButton,
        showOnlyCard: showOnlyCard,
        obscureNumber: obscureNumber,
        numberTextSize: numberTextSize,
        expiryTextSize: expiryTextSize,
        nameTextSize: nameTextSize,
        cardCompany: cardCompany,
        validationEnabled: validationEnabled,
        onNumberInvalid: onNumberInvalid,
        onValidationInvalid: onValidationInvalid,
        onNameInvalid: onNameInvalid,
        onCvvInvalid: onCvvInvalid,
        prevButtonDecoration: prevButtonDecoration,
        nextButtonDecoration: nextButtonDecoration,
        resetButtonDecoration: resetButtonDecoration,
        prevButtonTextStyle: prevButtonTextStyle,
        nextButtonTextStyle: nextButtonTextStyle,
        resetButtonTextStyle: resetButtonTextStyle,
        initialCardState: intialCardState,
      ),
    );
  }
}

class CreditCardInputImpl extends StatefulWidget {
  final CardInfoCallback onCardModelChanged;
  final double cardHeight;
  final BoxDecoration frontDecoration;
  final BoxDecoration backDecoration;
  final bool showResetButton;
  final bool showOnlyCard;
  final bool obscureNumber;
  final double numberTextSize;
  final double expiryTextSize;
  final double nameTextSize;
  final String cardCompany;
  final bool validationEnabled;
  final Function(BuildContext) onNumberInvalid;
  final Function(BuildContext) onValidationInvalid;
  final Function(BuildContext) onNameInvalid;
  final Function(BuildContext) onCvvInvalid;
  final BoxDecoration nextButtonDecoration;
  final BoxDecoration prevButtonDecoration;
  final BoxDecoration resetButtonDecoration;
  final TextStyle nextButtonTextStyle;
  final TextStyle prevButtonTextStyle;
  final TextStyle resetButtonTextStyle;
  final InputState initialCardState;

  CreditCardInputImpl(
      {this.onCardModelChanged,
      this.cardHeight,
      this.showResetButton,
      this.showOnlyCard,
      this.obscureNumber,
      this.numberTextSize,
      this.expiryTextSize,
      this.nameTextSize,
      this.cardCompany,
      this.validationEnabled,
      this.onNumberInvalid,
      this.onValidationInvalid,
      this.onNameInvalid,
      this.onCvvInvalid,
      this.frontDecoration,
      this.backDecoration,
      this.nextButtonTextStyle,
      this.prevButtonTextStyle,
      this.resetButtonTextStyle,
      this.nextButtonDecoration,
      this.prevButtonDecoration,
      this.initialCardState,
      this.resetButtonDecoration});

  @override
  _CreditCardInputImplState createState() => _CreditCardInputImplState();
}

class _CreditCardInputImplState extends State<CreditCardInputImpl> {
  PageController pageController;

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final _validator = CreditCardValidator();

  final cardHorizontalpadding = 12;
  final cardRatio = 16.0 / 9.0;

  var _currentState;

  @override
  void initState() {
    super.initState();

    _currentState = widget.initialCardState;

    pageController = PageController(
      viewportFraction: 0.92,
      initialPage: widget.initialCardState.index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final newState = Provider.of<StateProvider>(context).getCurrentState();

    final name = Provider.of<CardNameProvider>(context).cardName;

    final cardNumber = Provider.of<CardNumberProvider>(context).cardNumber;

    final valid = Provider.of<CardValidProvider>(context).cardValid;

    final cvv = Provider.of<CardCVVProvider>(context).cardCVV;

    final captions = Provider.of<Captions>(context);

    if (newState != _currentState) {
      _currentState = newState;

      Future(() {
        widget.onCardModelChanged(
            _currentState,
            CardInfo(
                name: name, cardNumber: cardNumber, validate: valid, cvv: cvv));
      });
    }

    double cardWidth =
        MediaQuery.of(context).size.width - (2 * cardHorizontalpadding);

    double cardHeight;
    if (widget.cardHeight != null && widget.cardHeight > 0) {
      cardHeight = widget.cardHeight;
    } else {
      cardHeight = cardWidth / cardRatio;
    }

    final frontDecoration = widget.frontDecoration != null
        ? widget.frontDecoration
        : defaultCardDecoration;
    final backDecoration = widget.backDecoration != null
        ? widget.backDecoration
        : defaultCardDecoration;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: FlipCard(
              speed: 300,
              flipOnTouch: _currentState == InputState.DONE,
              key: cardKey,
              front: FrontCardView(
                height: cardHeight,
                decoration: frontDecoration,
                obscureNumber: widget.obscureNumber,
                cardCompany: widget.cardCompany,
                numberTextSize: widget.numberTextSize,
                expiryTextSize: widget.expiryTextSize,
                nameTextSize: widget.nameTextSize
              ),
              back:
                  BackCardView(height: cardHeight, decoration: backDecoration),
            ),
          ),
          if (!widget.showOnlyCard) Stack(
            children: [
              AnimatedOpacity(
                opacity: _currentState == InputState.DONE ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: InputViewPager(
                  pageController: pageController,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                      opacity: widget.showResetButton &&
                              _currentState == InputState.DONE
                          ? 1
                          : 0,
                      duration: Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ResetButton(
                          decoration: widget.resetButtonDecoration,
                          textStyle: widget.resetButtonTextStyle,
                          onTap: () {
                            if (!widget.showResetButton) {
                              return;
                            }

                            Provider.of<StateProvider>(context, listen: false)
                                .moveFirstState();
                            pageController.animateToPage(0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);

                            if (!cardKey.currentState.isFront) {
                              cardKey.currentState.toggleCard();
                            }
                          },
                        ),
                      ))),
            ],
          ),
          if (!widget.showOnlyCard) Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            AnimatedOpacity(
              opacity: _currentState == InputState.NUMBER ||
                      _currentState == InputState.DONE
                  ? 0
                  : 1,
              duration: Duration(milliseconds: 500),
              child: RoundButton(
                  decoration: widget.prevButtonDecoration,
                  textStyle: widget.prevButtonTextStyle,
                  buttonTitle: captions.getCaption('PREV'),
                  onTap: () {
                    if (InputState.DONE == _currentState) {
                      return;
                    }

                    if (InputState.NUMBER != _currentState) {
                      pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }

                    if (InputState.CVV == _currentState) {
                      cardKey.currentState.toggleCard();
                    }
                    Provider.of<StateProvider>(context, listen: false)
                        .movePrevState();
                  }),
            ),
            SizedBox(
              width: 10,
            ),
            AnimatedOpacity(
              opacity: _currentState == InputState.DONE ? 0 : 1,
              duration: Duration(milliseconds: 500),
              child: RoundButton(
                  decoration: widget.nextButtonDecoration,
                  textStyle: widget.nextButtonTextStyle,
                  buttonTitle: _currentState == InputState.CVV ||
                          _currentState == InputState.DONE
                      ? captions.getCaption('DONE')
                      : captions.getCaption('NEXT'),
                  onTap: () async {
                    if (InputState.NUMBER == _currentState) {
                      final result = _validator.validateCCNum(Provider.of<CardNumberProvider>(context, listen: false).cardNumber);
                      if (widget.validationEnabled && !result.isValid) {
                        if (widget.onNumberInvalid != null) {
                          await widget.onNumberInvalid(context);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Number not valid"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok")
                                )
                              ],
                            )
                          );
                        }
                        return;
                      }
                    }

                    if (InputState.NAME == _currentState) {
                      final nameValid = Provider.of<CardNameProvider>(context, listen: false).cardName.length > 1;
                      if (widget.validationEnabled && !nameValid) {
                        if (widget.onNameInvalid != null) {
                          await widget.onNameInvalid(context);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Name not valid"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok")
                                )
                              ],
                            )
                          );
                        }
                        return;
                      }
                    }

                    if (InputState.VALIDATE == _currentState) {
                      final result = _validator.validateExpDate(Provider.of<CardValidProvider>(context, listen: false).cardValid);
                      if (widget.validationEnabled && !result.isValid) {
                        if (widget.onValidationInvalid != null) {
                          await widget.onValidationInvalid(context);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Validation date not valid"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok")
                                )
                              ],
                            )
                          );
                        }
                        return;
                      }
                      cardKey.currentState.toggleCard();
                    }

                    if (InputState.CVV == _currentState) {
                      final cvvValid = Provider.of<CardCVVProvider>(context, listen: false).cardCVV.length > 2;
                      if (widget.validationEnabled && !cvvValid) {
                        if (widget.onCvvInvalid != null) {
                          await widget.onCvvInvalid(context);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Cvv not valid"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok")
                                )
                              ],
                            )
                          );
                        }
                        return;
                      }

                      if (!cardKey.currentState.isFront) {
                        cardKey.currentState.toggleCard();
                      }
                    }

                    if (InputState.CVV != _currentState) {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }

                    Provider.of<StateProvider>(context, listen: false)
                        .moveNextState();
                  }),
            ),
            SizedBox(
              width: 25,
            )
          ])
        ],
      ),
    );
  }
}
