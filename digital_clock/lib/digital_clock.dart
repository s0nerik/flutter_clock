import 'package:digital_clock/clock.dart';
import 'package:digital_clock/layers/digits.dart';
import 'package:digital_clock/layers/mountains.dart';
import 'package:digital_clock/layers/sky.dart';
import 'package:digital_clock/layers/sky_gradient.dart';
import 'package:digital_clock/layers/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(const []);

    return Stack(
      children: [
        SkyGradient(),
        Sky(),
        Mountains(),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Weather(
            weatherCondition: ClockExtra.of(context).weatherCondition,
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.25,
            alignment: Alignment.center,
            child: Digits(),
          ),
        ),
      ],
    );
  }
}
