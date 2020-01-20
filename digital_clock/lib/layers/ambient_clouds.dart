import 'package:digital_clock/clock.dart';
import 'package:digital_clock/elements/clouds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class AmbientClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showAmbientClouds;
    switch (ClockExtra.of(context).weatherCondition) {
      case WeatherCondition.sunny:
        showAmbientClouds = true;
        break;
      default:
        showAmbientClouds = false;
        break;
    }
    if (!Clock.of(context).isDayTime) {
      showAmbientClouds = false;
    }
    return AnimatedSwitcher(
      duration: Clock.of(context).updateRate,
      child: showAmbientClouds ? Clouds(type: CloudType.ambient) : Container(),
    );
  }
}
