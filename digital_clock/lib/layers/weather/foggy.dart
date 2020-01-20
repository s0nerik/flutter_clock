import 'dart:math';

import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Foggy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherParticleAnimator(
          axis: Axis.horizontal,
          step: _fogStep,
          particleBuilder: (index, color, progress) => _FogPainter(
            index: index,
            color: color,
            progress: progress,
          ),
        ),
      ],
    );
  }
}

const _fogStep = 4.0;
const _fogWidth = _fogHeight * 16.0;
const _fogHeight = 8.0;

class _FogPainter extends CustomPainter {
  _FogPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  }) {
    rnd = Random(index);
    start = 0.3 + ((rnd.nextDouble() - 0.5) * 2) * 0.3;
    end = 0.3 + ((rnd.nextDouble() - 0.5) * 2) * 0.3;
    middle = (start + end) / 2;
  }

  final int index;
  final Color color;
  final double progress;

  Random rnd;
  double middle;
  double start;
  double end;

  @override
  void paint(Canvas canvas, Size size) {
    final p = progress <= 0.5 ? progress : 1 - progress;

    final paint = Paint()..color = color.withOpacity(p);
    final rect = RRect.fromLTRBR(
        0, 0, _fogWidth, _fogHeight, Radius.circular(_fogWidth / 2));

    final m = size.width * middle - _fogWidth / 2;
    final dx = size.width * (start + progress * (end - start));

    canvas.save();
    canvas.translate(m + dx, index * _fogStep);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
