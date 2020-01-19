import 'dart:math';

import 'package:digital_clock/clock.dart';
import 'package:digital_clock/elements/sun.dart';
import 'package:flutter/material.dart';

class Sky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final now = Clock.of(context).now;
      final sunrise = Clock.of(context).sunrise;
      final dayDuration = Clock.of(context).dayDuration;
      final isDayTime = Clock.of(context).isDayTime;

      final containerSize = Size(
        constraints.maxWidth - kSunSize,
        constraints.maxHeight - kSunSize,
      );

      double x;
      double y;
      double opacity;
      if (isDayTime) {
        final sinceSunrise = now.difference(sunrise);
        final dayProgress = sinceSunrise.inSeconds / dayDuration.inSeconds;
        final progressRad = pi - pi * dayProgress;
        x = containerSize.width / 2 +
            containerSize.width / 2 * cos(progressRad);
        y = containerSize.height / 2 +
            containerSize.height / 2 * sin(progressRad);
        opacity = 1;
      } else {
        x = 0;
        y = 0;
        opacity = 0;
      }

      return Stack(
        children: <Widget>[
          Positioned(
            left: x,
            bottom: y,
            child: Opacity(
              opacity: opacity,
              child: Sun(),
            ),
          ),
        ],
      );
    });
  }
}
