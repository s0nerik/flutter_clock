import 'package:digital_clock/clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Digits extends StatelessWidget {
  const Digits({
    Key key,
    @required this.digitColor,
  }) : super(key: key);

  final Color digitColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dateTime = Clock.of(context).now;
        final is24HourFormat = ClockExtra.of(context).is24HourFormat;

        final hour = DateFormat(is24HourFormat ? 'HH' : 'hh').format(dateTime);
        final minute = DateFormat('mm').format(dateTime);
        final second = DateFormat('ss').format(dateTime);

        final digits = <int>[
          int.parse(hour[0]),
          int.parse(hour[1]),
          int.parse(minute[0]),
          int.parse(minute[1]),
          int.parse(second[0]),
          int.parse(second[1]),
        ];

        final digitWidth = constraints.maxWidth / 6;
        final digitHeight = constraints.maxHeight;

        final secondDigitWidth = digitWidth / 2;
        final secondDigitHeight = digitHeight / 2;

        final tickerWidth = 2 * digitWidth / 3;

        final freeWidth = constraints.maxWidth -
            digitWidth * 4 -
            tickerWidth -
            secondDigitWidth * 2;

        final digitsMarginWidth = freeWidth / 3;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[0], color: digitColor),
            ),
            SizedBox(width: digitsMarginWidth),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[1], color: digitColor),
            ),
            SizedBox(
              width: tickerWidth,
              height: digitHeight,
              child: _Ticker(color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[2], color: digitColor),
            ),
            SizedBox(width: digitsMarginWidth),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[3], color: digitColor),
            ),
            SizedBox(width: 2 * digitsMarginWidth / 3),
            Column(
              children: <Widget>[
                Expanded(child: _AmPmIndicator(color: digitColor)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: secondDigitWidth,
                      height: secondDigitHeight,
                      child: _Digit(digit: digits[4], color: digitColor),
                    ),
                    SizedBox(width: 1 * digitsMarginWidth / 3),
                    SizedBox(
                      width: secondDigitWidth,
                      height: secondDigitHeight,
                      child: _Digit(digit: digits[5], color: digitColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AmPmIndicator extends StatelessWidget {
  const _AmPmIndicator({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    if (ClockExtra.of(context).is24HourFormat) {
      return Container();
    } else {
      final amPm = DateFormat('a').format(Clock.of(context).now);
      Widget child;
      if (amPm == 'AM') {
        child = Container();
      } else {
        child = Center(
          child: Text(
            amPm,
            style: TextStyle(
              fontFamily: 'RussoOne',
              fontSize: 42,
              color: color,
            ),
          ),
        );
      }
      return AnimatedSwitcher(
        duration: Clock.of(context).updateRate,
        child: child,
      );
    }
  }
}

class _Digit extends StatelessWidget {
  const _Digit({
    Key key,
    @required this.digit,
    this.color,
    this.callback,
  }) : super(key: key);

  final int digit;
  final Color color;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey<int>(digit),
      child: FlareActor(
        'assets/numbers.flr',
        artboard: 'Anim',
        animation: '${(digit - 1) % 10} -> $digit',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        callback: callback,
        color: color,
      ),
    );
  }
}

class _Ticker extends StatelessWidget {
  const _Ticker({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/numbers.flr',
      artboard: 'Ticker',
      animation: 'tick',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
