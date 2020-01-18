import 'package:digital_clock/layers/weather/cloudy.dart';
import 'package:digital_clock/layers/weather/foggy.dart';
import 'package:digital_clock/layers/weather/rain.dart';
import 'package:digital_clock/layers/weather/snow.dart';
import 'package:digital_clock/layers/weather/thunderstorm.dart';
import 'package:digital_clock/layers/weather/wind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Weather extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const Weather({
    Key key,
    @required this.weatherCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBackground(weatherCondition);
  }
}

Widget _buildBackground(WeatherCondition weatherCondition) {
  switch (weatherCondition) {
    case WeatherCondition.cloudy:
      return Cloudy();
    case WeatherCondition.foggy:
      return Foggy();
    case WeatherCondition.rainy:
      return Rain();
    case WeatherCondition.snowy:
      return Snow();
    case WeatherCondition.sunny:
      // TODO: Handle this case.
      break;
    case WeatherCondition.thunderstorm:
      return Thunderstorm();
    case WeatherCondition.windy:
      return Wind();
  }
  return const SizedBox.shrink();
}
