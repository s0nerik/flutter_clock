import 'package:digital_clock/model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Foreground extends StatelessWidget {
  const Foreground({
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
  return 'fg';
  switch (season) {
    case Season.spring:
      return 'fg_spring';
    case Season.summer:
      return 'fg_summer';
    case Season.autumn:
      return 'fg_autumn';
    case Season.winter:
      return 'fg_winter';
  }
}
