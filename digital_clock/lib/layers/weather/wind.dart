import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Wind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.horizontal,
      step: _windStreamStep,
      particleBuilder: (index, color, progress) => _WindPainter(
        color: color,
        progress: progress,
      ),
    );
  }
}

const _windStreamStep = 16.0;
const _windStreamWidth = _windStreamHeight * 16.0;
const _windStreamHeight = 8.0;

class _WindPainter extends CustomPainter {
  _WindPainter({
    @required this.index,
    @required this.color,
    @required this.progress,
  });

  final int index;
  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(1 - progress);
    final rect = RRect.fromLTRBR(0, 0, _windStreamWidth, _windStreamHeight,
        Radius.circular(_windStreamWidth / 2));

    canvas.save();
    canvas.translate(size.width * progress - _windStreamWidth * (1 - progress),
        index * _windStreamStep);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
