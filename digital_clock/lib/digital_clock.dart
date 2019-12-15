import 'package:digital_clock/layers/clouds.dart';
import 'package:digital_clock/layers/digits.dart';
import 'package:digital_clock/layers/background.dart';
import 'package:digital_clock/layers/foreground.dart';
import 'package:digital_clock/layers/weather.dart';
import 'package:digital_clock/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

class DigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(const []);

    return Stack(
      children: [
        Background(season: Season.summer),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Weather(
            weatherCondition: Provider.of<ClockModel>(context).weatherCondition,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Clouds(),
        ),
        Foreground(season: Season.summer),
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
