import 'package:digital_clock/clock.dart';
import 'package:digital_clock/model.dart';
import 'package:digital_clock/util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

const _dayColors = [
  Color(0xFF373866), Color(0xFFE0CFD9), Color(0xFF00AFEF), Color(0xFFE0CFD9),
];

final _topColors = _dayColors;
final _bottomColors = _dayColors.map((c) => darken(c, 0.25)).toList();

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    final now = Clock.of(context).now;
    final timeUpdateRate = Clock.of(context).updateRate;

    final partOfDayLength = 24 / _topColors.length;
    final partOfDay = now.hour ~/ partOfDayLength;
    final partOfPartOfDay = (now.hour - partOfDay * partOfDayLength) / partOfDayLength;

    final topColor = _topColors[partOfDay];
    final nextTopColor = _topColors[(partOfDay + 1) % _topColors.length];

    final bottomColor = _bottomColors[partOfDay];
    final nextBottomColor = _bottomColors[(partOfDay + 1) % _bottomColors.length];

    final top = Color.lerp(topColor, nextTopColor, partOfPartOfDay);
    final bottom = Color.lerp(bottomColor, nextBottomColor, partOfPartOfDay);

    return AnimatedContainer(
      duration: timeUpdateRate,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ),
      ),
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
