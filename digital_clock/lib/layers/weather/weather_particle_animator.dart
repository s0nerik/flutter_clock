import 'dart:math';

import 'package:flutter/material.dart';

typedef ParticlePainterBuilder = CustomPainter Function(
    Color color, double animationProgress);

class WeatherParticleAnimator extends StatelessWidget {
  const WeatherParticleAnimator({
    Key key,
    @required this.particleBuilder,
    @required this.axis,
    @required this.step,
  }) : super(key: key);

  final ParticlePainterBuilder particleBuilder;
  final Axis axis;
  final double step;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final raindrops = <Widget>[];
        final maxValue = axis == Axis.vertical
            ? constraints.maxWidth
            : constraints.maxHeight;
        for (var i = 0.0; i < maxValue; i += step) {
          raindrops.add(
            Padding(
              padding: EdgeInsets.only(left: i),
              child: _Particle(
                index: i ~/ step,
                particleBuilder: particleBuilder,
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.topLeft,
          children: raindrops,
        );
      },
    );
  }
}

class _Particle extends StatefulWidget {
  const _Particle({
    Key key,
    @required this.index,
    @required this.particleBuilder,
  }) : super(key: key);

  final int index;
  final ParticlePainterBuilder particleBuilder;

  @override
  _ParticleState createState() => _ParticleState();
}

class _ParticleState extends State<_Particle>
    with TickerProviderStateMixin<_Particle> {
  AnimationController _ctrl;
  Random _rnd;

  @override
  void initState() {
    super.initState();
    _rnd = Random(widget.index);
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000 + _rnd.nextInt(1000)),
    );
    _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = _ctrl.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    return LayoutBuilder(
      builder: (_, constraints) => AnimatedBuilder(
        animation: anim,
        builder: (context, _) => CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: widget.particleBuilder(Colors.white, anim.value),
        ),
      ),
    );
  }
}
