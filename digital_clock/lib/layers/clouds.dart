import 'package:digital_clock/elements/cloud.dart';
import 'package:flutter/material.dart';

class Clouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const cloudStep = 64.0;
        final clouds = <Widget>[];
        for (var x = 0.0; x < constraints.maxWidth; x += cloudStep) {
          clouds.add(
            Padding(
              padding: EdgeInsets.only(left: x),
              child: Cloud(
                index: (x ~/ cloudStep) % 4,
                animationType: AnimationType.rain,
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.topLeft,
          children: clouds,
        );
      }
    );
  }
}
