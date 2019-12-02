import 'package:digital_clock/digits.dart';
import 'package:digital_clock/layers/background.dart';
import 'package:digital_clock/layers/foreground.dart';
import 'package:digital_clock/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(const []);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Background(season: Season.summer),
        Foreground(season: Season.summer),
        Container(
          height: MediaQuery.of(context).size.height / 2.25,
          alignment: Alignment.center,
          child: Digits(),
        ),
      ],
    );
  }
}
