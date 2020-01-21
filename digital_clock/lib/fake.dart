import 'package:meta/meta.dart';

class FakeTimeProvider {
  final DateTime initialDate;
  final Duration increaseBy;
  final Duration minTime;
  final Duration maxTime;

  DateTime _fakeDate;

  FakeTimeProvider({
    @required this.initialDate,
    @required this.increaseBy,
    this.minTime = const Duration(),
    this.maxTime = const Duration(hours: 24),
  }) : assert(initialDate.isUtc) {
    _fakeDate = DateTime(initialDate.year, initialDate.month, initialDate.day)
        .add(minTime);
  }

  DateTime call() {
    final fakeDate = _fakeDate.add(increaseBy);
    final fakeTime = Duration(
      hours: _fakeDate.hour,
      minutes: _fakeDate.minute,
      seconds: _fakeDate.second,
    );
    if (fakeTime > maxTime || fakeTime < minTime) {
      final startOfDay = DateTime(fakeDate.year, fakeDate.month, fakeDate.day);
      final tomorrowStart = startOfDay.add(Duration(days: 1)).add(minTime);
      _fakeDate = tomorrowStart;
    } else {
      _fakeDate = fakeDate;
    }
    return _fakeDate;
  }
}
