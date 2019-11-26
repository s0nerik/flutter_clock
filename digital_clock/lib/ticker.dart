import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Ticker extends StatelessWidget {
  const Ticker({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/numbers.flr',
      artboard: 'Ticker',
      animation: 'tick',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
