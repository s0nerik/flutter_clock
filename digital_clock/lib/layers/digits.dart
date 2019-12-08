import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Digits extends StatefulWidget {
  @override
  _DigitsState createState() => _DigitsState();
}

class _DigitsState extends State<Digits> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ClockModel>(context);

    final hour =
        DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    final digits = <int>[
      int.parse(hour[0]),
      int.parse(hour[1]),
      int.parse(minute[0]),
      int.parse(minute[1]),
      int.parse(second[0]),
      int.parse(second[1]),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final digitWidth = constraints.maxWidth / 8;
        final digitHeight = 100.0;
        final digitColor = Colors.white;
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[0], color: digitColor),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[1], color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Ticker(color: digitColor),
            ),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[2], color: digitColor),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: digitWidth,
              height: digitHeight,
              child: _Digit(digit: digits[3], color: digitColor),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: digitWidth / 2,
              height: digitHeight / 2,
              child: _Digit(digit: digits[4], color: digitColor),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: digitWidth / 2,
              height: digitHeight / 2,
              child: _Digit(digit: digits[5], color: digitColor),
            ),
          ],
        );
      },
    );
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
