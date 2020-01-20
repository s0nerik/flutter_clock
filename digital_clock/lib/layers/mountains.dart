import 'package:digital_clock/clock.dart';
import 'package:flutter/material.dart';

class Mountains extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/mountains_night.png',
          fit: BoxFit.fitWidth,
        ),
        AnimatedOpacity(
          duration: Clock.of(context).updateRate,
          opacity: Clock.of(context).isDayTime ? 1.0 : 0.0,
          child: Image.asset(
            'assets/mountains_day.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
