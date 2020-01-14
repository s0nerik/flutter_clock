import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Rain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherParticleAnimator(
      axis: Axis.vertical,
      step: 16,
      minAnimDuration: const Duration(milliseconds: 500),
      maxAnimDuration: const Duration(seconds: 1),
      particleBuilder: (_, color, progress) => _RaindropPainter(
        color: color,
        progress: progress,
      ),
    );
  }
}

const _raindropWidth = 8.0;
const _raindropHeight = _raindropWidth * 5;

class _RaindropPainter extends CustomPainter {
  _RaindropPainter({
    @required this.color,
    @required this.progress,
  });

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    double opacity;
    if (progress < 0.2) {
      opacity = progress * 5;
    } else {
      opacity = 1 - progress;
    }

    final paint = Paint()..color = color.withOpacity(opacity);
    final rect = RRect.fromLTRBR(0, 0, _raindropWidth, _raindropHeight,
        Radius.circular(_raindropWidth / 2));

    canvas.save();
    canvas.translate(0, size.height * progress);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
