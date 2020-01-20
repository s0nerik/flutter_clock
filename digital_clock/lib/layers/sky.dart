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
      final sunContainerSize = Size(
        constraints.maxWidth - kSunSize,
        constraints.maxHeight - kSunSize,
      );

      final moonContainerSize = Size(
        constraints.maxWidth - kMoonSize,
        constraints.maxHeight - kMoonSize,
      );

      final sunPosition = Clock.of(context).sunPosition;
      final sunX = sunContainerSize.width / 2 +
          sunContainerSize.width / 2 * cos(sunPosition);
      final sunY = sunContainerSize.height / 2 +
          sunContainerSize.height / 2 * sin(sunPosition);

      final moonPosition = Clock.of(context).moonPosition;
      final moonX = moonContainerSize.width / 2 +
          moonContainerSize.width / 2 * cos(moonPosition);
      final moonY = moonContainerSize.height / 2 +
          moonContainerSize.height / 2 * sin(moonPosition);

      final starsOpacity = Clock.of(context).isDayTime ? 0.0 : 1.0;

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
            child: Sun(),
          ),
          AnimatedPositioned(
            duration: Clock.of(context).updateRate,
            left: moonX,
            bottom: moonY,
            child: Moon(),
          ),
        ],
      );
    });
  }
}
