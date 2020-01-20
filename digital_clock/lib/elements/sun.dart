import 'package:digital_clock/clock.dart';
import 'package:digital_clock/util/animated_rotation.dart';
import 'package:flutter/material.dart';

const kSunSize = 120.0;

class Sun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      rotation: -Clock.of(context).sunPosition,
      duration: Clock.of(context).updateRate,
      child: Container(
        width: kSunSize,
        height: kSunSize,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade600, Colors.yellow.shade900],
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
