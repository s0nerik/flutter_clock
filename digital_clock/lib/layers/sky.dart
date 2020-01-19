import 'dart:math';

import 'package:digital_clock/clock.dart';
import 'package:digital_clock/elements/moon.dart';
import 'package:digital_clock/elements/sun.dart';
import 'package:digital_clock/layers/stars.dart';
import 'package:flutter/material.dart';

class Sky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final now = Clock.of(context).now;
      final sunrise = Clock.of(context).sunrise;
      final sunset = Clock.of(context).sunset;
      final dayDuration = Clock.of(context).dayDuration;
      final nightDuration = Clock.of(context).nightDuration;
      final isDayTime = Clock.of(context).isDayTime;

      final sunContainerSize = Size(
        constraints.maxWidth - kSunSize,
        constraints.maxHeight - kSunSize,
      );

      final moonContainerSize = Size(
        constraints.maxWidth - kMoonSize,
        constraints.maxHeight - kMoonSize,
      );

      double sunX = 0;
      double sunY = 0;
      double sunOpacity = 0;

      double moonX = 0;
      double moonY = 0;
      double moonOpacity = 0;

      double starsOpacity = 0;

      if (isDayTime) {
        final sinceSunrise = now.difference(sunrise);
        final dayProgress = sinceSunrise.inSeconds / dayDuration.inSeconds;
        final progressRad = pi - pi * dayProgress;
        sunX = sunContainerSize.width / 2 +
            sunContainerSize.width / 2 * cos(progressRad);
        sunY = sunContainerSize.height / 2 +
            sunContainerSize.height / 2 * sin(progressRad);
        sunOpacity = 1;
      } else {
        final sinceSunset = now.difference(sunset);
        final nightProgress = sinceSunset.inSeconds / nightDuration.inSeconds;
        final progressRad = pi - pi * nightProgress;
        moonX = moonContainerSize.width / 2 +
            moonContainerSize.width / 2 * cos(progressRad);
        moonY = moonContainerSize.height / 2 +
            moonContainerSize.height / 2 * sin(progressRad);
        moonOpacity = 1;
        starsOpacity = 1;
      }

      return Stack(
        children: <Widget>[
          AnimatedOpacity(
            duration: Clock.of(context).updateRate,
            opacity: starsOpacity,
            child: Stars(),
          ),
          AnimatedPositioned(
            duration: Clock.of(context).updateRate,
            left: sunX,
            bottom: sunY,
            child: AnimatedOpacity(
              duration: Clock.of(context).updateRate,
              opacity: sunOpacity,
              child: Sun(),
            ),
          ),
          AnimatedPositioned(
            duration: Clock.of(context).updateRate,
            left: moonX,
            bottom: moonY,
            child: AnimatedOpacity(
              duration: Clock.of(context).updateRate,
              opacity: moonOpacity,
              child: Moon(),
            ),
          ),
        ],
      );
    });
  }
}
