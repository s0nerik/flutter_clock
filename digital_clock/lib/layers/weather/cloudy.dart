import 'dart:math';

import 'package:digital_clock/elements/cloud.dart';
import 'package:flutter/material.dart';

class Cloudy extends StatefulWidget {
  @override
  _CloudyState createState() => _CloudyState();
}

class _CloudyState extends State<Cloudy> {
  final _clouds = <Widget>[];
  BoxConstraints _constraints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const cloudStep = 32.0;
      if (_constraints != constraints) {
        _clouds.clear();
      }
      _constraints = constraints;

      if (_clouds.isEmpty) {
        final rnd = Random(DateTime.now().millisecondsSinceEpoch);
        for (var x = -256.0; x < constraints.maxWidth; x += cloudStep) {
          _clouds.add(
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
                  darkColor: Colors.grey[400].withOpacity(0.85),
                  lightColor: Colors.grey[100].withOpacity(0.85),
                  animationDuration:
                      Duration(milliseconds: 1500 + rnd.nextInt(1000)),
                  animationStartDelay:
                      Duration(milliseconds: rnd.nextInt(2000)),
                  animationType: AnimationType.rain,
                ),
              ),
            ),
          );
        }
      }

      return Stack(
        alignment: Alignment.topLeft,
        children: _clouds,
      );
    });
  }
}
