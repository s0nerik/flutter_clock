import 'dart:math';

import 'package:digital_clock/layers/weather/weather_particle_animator.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class Foggy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
//        _Background(),
        WeatherParticleAnimator(
          axis: Axis.horizontal,
          step: 4,
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

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(
        Duration(seconds: 3),
        ColorTween(
          begin: Colors.white.withOpacity(0),
          end: Colors.white.withOpacity(0.1),
        ),
      ),
      Track("color2").add(
        Duration(seconds: 6),
        ColorTween(
          begin: Colors.white.withOpacity(0.8),
          end: Colors.white.withOpacity(0.4),
        ),
      ),
      Track("color3").add(
        Duration(seconds: 2),
        ColorTween(
          begin: Colors.white.withOpacity(0.75),
          end: Colors.white.withOpacity(0.5),
        ),
      ),
      Track("color4").add(
        Duration(seconds: 3),
        ColorTween(
          begin: Colors.white.withOpacity(0.9),
          end: Colors.white.withOpacity(0.4),
        ),
      ),
      Track("color5").add(
        Duration(seconds: 3),
        ColorTween(
          begin: Colors.white.withOpacity(0),
          end: Colors.white.withOpacity(0.1),
        ),
      ),
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                animation["color1"],
                animation["color2"],
                animation["color3"],
                animation["color4"],
                animation["color5"],
              ],
            ),
          ),
        );
      },
    );
  }
}

const _windStreamWidth = _windStreamHeight * 16.0;
const _windStreamHeight = 8.0;

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
    final rect = RRect.fromLTRBR(0, 0, _windStreamWidth, _windStreamHeight,
        Radius.circular(_windStreamWidth / 2));

    final m = size.width * middle - _windStreamWidth / 2;
    final dx = size.width * (start + progress * (end - start));

    canvas.save();
    canvas.translate(m + dx, 0);
    canvas.drawRRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
