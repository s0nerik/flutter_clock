import 'package:flutter/material.dart';

const kMoonSize = 120.0;

class Moon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kMoonSize,
      height: kMoonSize,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
