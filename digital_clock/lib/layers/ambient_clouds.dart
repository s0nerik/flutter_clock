import 'package:digital_clock/clock.dart';
import 'package:digital_clock/elements/clouds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class AmbientClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final showAmbientClouds = Clock.of(context).isDayTime &&
//        ClockExtra.of(context).weatherCondition == WeatherCondition.sunny;

    final showAmbientClouds =
        ClockExtra.of(context).weatherCondition == WeatherCondition.sunny;

    return AnimatedSwitcher(
      duration: Clock.of(context).updateRate,
      child: showAmbientClouds ? Clouds(type: CloudType.ambient) : Container(),
    );
  }
}
