import 'package:digital_clock/model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/layers.flr',
      artboard: _artboard(season),
    );
  }
}

String _artboard(Season season) {
  switch (season) {
    case Season.spring:
      return 'bg_spring';
    case Season.summer:
      return 'bg_summer';
    case Season.autumn:
      return 'bg_autumn';
    case Season.winter:
      return 'bg_winter';
  }
}
