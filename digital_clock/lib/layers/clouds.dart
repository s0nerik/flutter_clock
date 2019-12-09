import 'dart:math';

import 'package:digital_clock/elements/cloud.dart';
import 'package:flutter/material.dart';

class Clouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const cloudStep = 32.0;
      final clouds = <Widget>[];
      final rnd = Random(DateTime.now().millisecondsSinceEpoch);
      for (var x = -256.0; x < constraints.maxWidth; x += cloudStep) {
        clouds.add(
          Positioned(
            left: x,
            top: (rnd.nextDouble() - 1.25) * 64,
            child: SizedBox(
              width: 256,
              height: 128,
              child: Cloud(
                typeIndex: (x ~/ cloudStep) % 4,
                minScale: rnd.nextDouble() * 0.25 + 0.5,
                maxScale: rnd.nextDouble() * 0.25 + 0.75,
                darkColor: Colors.grey[400],
                lightColor: Colors.grey[100],
                animationDuration:
                    Duration(milliseconds: 500 + rnd.nextInt(1000)),
                animationStartDelay: Duration(milliseconds: rnd.nextInt(2000)),
                animationType: AnimationType.rain,
              ),
            ),
          ),
        );
      }

      return Stack(
        alignment: Alignment.topLeft,
        children: clouds,
      );
    });
  }
}
