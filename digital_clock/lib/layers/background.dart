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
    ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900);
    ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600);

    return Container(
      color: Colors.black,
    );

    return FlareActor(
      'assets/__bg__.flr',
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
