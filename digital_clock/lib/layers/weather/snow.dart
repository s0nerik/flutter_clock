import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Snow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.vertical,
      step: 16,
      particleBuilder: (color, progress) => _SnowflakePainter(
        color: color,
        progress: progress,
      ),
    );
  }
}

const _snowflakeWidth = 8.0;

class _SnowflakePainter extends CustomPainter {
  _SnowflakePainter({
    @required this.color,
    @required this.progress,
  });

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(1 - progress);

    canvas.save();
    canvas.translate(0, size.height * progress);
    canvas.drawCircle(
        Offset(_snowflakeWidth / 2, size.height * progress), 8, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
