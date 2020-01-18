import 'dart:math';

import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Sunny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    return WeatherParticleAnimator(
      axis: Axis.vertical,
      step: _flareStep,
      minAnimDuration: Duration(seconds: 1),
      maxAnimDuration: Duration(seconds: 2),
      minAnimDelay: Duration(seconds: 1),
      maxAnimDelay: Duration(seconds: 30),
      particleBuilder: (index, color, progress) => _FlarePainter(
        index: index,
        color: color,
        progress: progress,
      ),
    );
  }
}

const _flareWidth = 8.0;
const _flareStep = _flareWidth * 2;

final _rnd = Random(DateTime.now().millisecondsSinceEpoch);

/// Index -> position mapping
final _flarePositions = <int, double>{};

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
    final opacity = progress < 0.5 ? progress : 1 - progress;
    final paint = Paint()..color = color.withOpacity(opacity);

    final position = _flarePositions[index] ??= _rnd.nextDouble();

    final width = max(_flareWidth, _flareWidth * 4 * progress);

    canvas.save();
    canvas.translate(index * _flareStep, size.height * position);
    canvas.drawCircle(
        Offset(width / 2, width / 2), width, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
