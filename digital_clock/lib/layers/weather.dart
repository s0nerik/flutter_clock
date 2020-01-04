import 'package:digital_clock/layers/weather/rain.dart';
import 'package:digital_clock/layers/weather/snow.dart';
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
      // TODO: Handle this case.
      break;
    case WeatherCondition.foggy:
      // TODO: Handle this case.
      break;
    case WeatherCondition.rainy:
      return Rain();
    case WeatherCondition.snowy:
      return Snow();
    case WeatherCondition.sunny:
      // TODO: Handle this case.
      break;
    case WeatherCondition.thunderstorm:
      // TODO: Handle this case.
      break;
    case WeatherCondition.windy:
      return Wind();
  }
  return const SizedBox.shrink();
}