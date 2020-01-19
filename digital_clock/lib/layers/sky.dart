import 'dart:math';

import 'package:digital_clock/clock.dart';
import 'package:flutter/material.dart';

class Sky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final now = Clock.of(context).now;
      final sunrise = Clock.of(context).sunrise;
      final sunset = Clock.of(context).sunset;
      final noon = Clock.of(context).noon;
      final dayDuration = Clock.of(context).dayDuration;
      final isDayTime = Clock.of(context).isDayTime;

      final tillSunrise = sunrise.difference(now);
      final tillSunset = sunset.difference(now);
      final tillNoon = noon.difference(now);

      final sunSize = 120.0;
//      final containerSize = Size(constraints.maxWidth / 2 - sunSize, constraints.maxHeight / 2 - sunSize / 2);

      double x;
      double y;
      double opacity;
      if (isDayTime) {
        final sinceSunrise = now.difference(sunrise);
        final dayProgress = sinceSunrise.inSeconds / dayDuration.inSeconds;
        final progressRad = pi - pi * dayProgress;
        x = constraints.maxWidth / 2 + constraints.maxWidth / 2 * cos(progressRad);
        y = constraints.maxHeight / 2 + constraints.maxHeight / 2 * sin(progressRad);
        opacity = 1;
      } else {
        x = 0;
        y = 0;
        opacity = 0;
      }

      return Stack(
        children: <Widget>[
          Positioned(
            left: x - sunSize / 2,
            bottom: y - sunSize / 2,
            width: sunSize,
            height: sunSize,
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.yellowAccent,
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      );
    });
  }
}
