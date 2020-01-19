import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

typedef DateTimeProvider = DateTime Function();

class Clock with ChangeNotifier {
  final DateTimeProvider _dateTimeProvider;
  final Duration updateRate;

  DateTime _dateTime;
  Timer _timer;

  DateTime get now => _dateTime;

  // Could've been real if lat/lng were available
  final _sunriseOffset = Duration(hours: 5);
  final _sunsetOffset = Duration(hours: 17);

  DateTime get sunrise =>
      DateTime(now.year, now.month, now.day).add(_sunriseOffset);

  DateTime get sunset =>
      DateTime(now.year, now.month, now.day).add(_sunsetOffset);

  DateTime get noon => sunset.subtract(_sunriseOffset);

  Duration get dayDuration => _sunsetOffset - _sunriseOffset;

  Duration get nightDuration =>
      const Duration(hours: 24) - _sunsetOffset + _sunriseOffset;

  bool get isDayTime =>
      (now.isAfter(sunrise) || now.isAtSameMomentAs(sunrise)) &&
      (now.isBefore(sunset) || now.isAtSameMomentAs(sunset));

  Clock({
    this.updateRate = const Duration(seconds: 1),
    DateTimeProvider dateTimeProvider,
  })  : assert(updateRate != null),
        _dateTimeProvider = dateTimeProvider ?? (() => DateTime.now()) {
    _updateTime();
  }

  void _updateTime() {
    _dateTime = _dateTimeProvider();
    _timer = Timer(
      Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      _updateTime,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  static Clock of(BuildContext context) => Provider.of(context);
}

class ClockExtra {
  static ClockModel of(BuildContext context) => Provider.of(context);
}
