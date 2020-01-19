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

      double sunX = 0;
      double sunY = 0;
      double sunOpacity = 0;
      if (isDayTime) {
        final sinceSunrise = now.difference(sunrise);
        final dayProgress = sinceSunrise.inSeconds / dayDuration.inSeconds;
        final progressRad = pi - pi * dayProgress;
        sunX = containerSize.width / 2 +
            containerSize.width / 2 * cos(progressRad);
        sunY = containerSize.height / 2 +
            containerSize.height / 2 * sin(progressRad);
        sunOpacity = 1;
      } else {
        sunX = 0;
        sunY = 0;
        sunOpacity = 0;
      }

      return Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Clock.of(context).updateRate,
            left: sunX,
            bottom: sunY,
            child: Opacity(
              opacity: sunOpacity,
              child: Sun(),
            ),
          ),
        ],
      );
    });
  }
}
