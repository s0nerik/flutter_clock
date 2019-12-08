import 'package:digital_clock/elements/cloud.dart';
import 'package:digital_clock/layers/slideshow.dart';
import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Slideshow(),
//        Center(
//          child: Cloud(index: 3),
//        )
//      ],
//    );

    return Container(
      color: Colors.black,
      child: Center(
        child: Cloud(
          index: 1,
          animationType: AnimationType.idle,
        ),
      ),
    );
  }
}
