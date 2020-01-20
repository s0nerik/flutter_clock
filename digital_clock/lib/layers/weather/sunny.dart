import 'dart:math';

import 'package:digital_clock/clock.dart';
import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Sunny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!Clock.of(context).isDayTime) {
      return Container();
    }
    return WeatherParticleAnimator(
      axis: Axis.horizontal,
      step: _flareStep,
      minAnimDuration: Duration(milliseconds: 500),
      maxAnimDuration: Duration(seconds: 1),
      minAnimDelay: Duration(),
      maxAnimDelay: Duration(seconds: 30),
      particleBuilder: (index, color, progress) => _FlarePainter(
        index: index,
        color: color,
        progress: progress,
      ),
    );
  }
}

const _flareStep = 4.0;

final _rnd = Random(DateTime.now().millisecondsSinceEpoch);

final _positions = <int, Offset>{};
final _radii = <int, double>{};

class _FlarePainter extends CustomPainter {
  _FlarePainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  });

  final int index;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    double p = progress <= 0.5 ? progress : 1 - progress;
    p = p / 2;

    final m =
        _positions[index] ??= Offset(_rnd.nextDouble(), _rnd.nextDouble());

    final baseRadius =
        _radii[index] ??= size.height / 6 - _rnd.nextDouble() * size.height / 8;

    final paint = Paint()..color = color.withOpacity(p);

    final r = baseRadius * (progress * 0.2 + 0.8);

    canvas.drawCircle(Offset(size.width * m.dx, size.height * m.dy), r, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
