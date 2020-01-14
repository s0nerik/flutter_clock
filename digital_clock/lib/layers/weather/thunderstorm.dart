import 'package:digital_clock/layers/weather/rain.dart';
import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';

class Thunderstorm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Rain(),
        WeatherParticleAnimator(
          axis: Axis.vertical,
          step: 250,
          minAnimDuration: Duration(milliseconds: 250),
          maxAnimDuration: Duration(milliseconds: 500),
          particleBuilder: (_, color, progress) => _LightningPainter(
            color: Colors.yellowAccent,
            progress: progress,
          ),
        ),
      ],
    );
  }
}

const _lightningWidth = 64.0;

final _paths = [
  (Size size) => Path()
    ..lineTo(_lightningWidth * 0.00, 0)
    ..lineTo(_lightningWidth * 0.66, size.height * 0.3)
    ..lineTo(_lightningWidth * 0.33, size.height * 0.6)
    ..lineTo(_lightningWidth * 1.00, size.height * 1.0)
    ..lineTo(_lightningWidth * 0.45, size.height * 0.6)
    ..lineTo(_lightningWidth * 0.75, size.height * 0.3)
    ..lineTo(_lightningWidth * 0.12, 0)
    ..close(),
  (Size size) => Path()
    ..lineTo(_lightningWidth * 0.00, 0)
    ..lineTo(_lightningWidth * 0.66, size.height * 0.3)
    ..lineTo(_lightningWidth * 0.33, size.height * 0.6)
    ..lineTo(_lightningWidth * 1.00, size.height * 1.0)
    ..lineTo(_lightningWidth * 0.45, size.height * 0.6)
    ..lineTo(_lightningWidth * 0.75, size.height * 0.3)
    ..lineTo(_lightningWidth * 0.12, 0)
    ..close(),
];

class _LightningPainter extends CustomPainter {
  _LightningPainter({
    @required this.color,
    @required this.progress,
  });

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(progress);
    final rect = Rect.fromLTWH(0, 0, _lightningWidth, size.height * progress);

    canvas.clipPath(_paths[0](size));
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
