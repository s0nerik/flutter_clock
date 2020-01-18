import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Snow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.vertical,
      step: _snowflakeStep,
      particleBuilder: (index, color, progress) => _SnowflakePainter(
        index: index,
        color: color,
        progress: progress,
      ),
    );
  }
}

const _snowflakeStep = 16.0;
const _snowflakeWidth = 8.0;

class _SnowflakePainter extends CustomPainter {
  _SnowflakePainter({
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

    canvas.save();
    canvas.translate(index * _snowflakeStep, size.height * progress);
    canvas.drawCircle(
        Offset(_snowflakeWidth / 2, size.height * progress), 8, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
