import 'package:flutter/material.dart';

const kSunSize = 120.0;

class Sun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kSunSize,
      height: kSunSize,
      decoration: ShapeDecoration(
        color: Colors.yellowAccent,
        shape: CircleBorder(),
      ),
    );
  }
}
