import 'dart:math';

import 'package:flutter/material.dart';

typedef ParticlePainterBuilder = CustomPainter Function(
    int index, Color color, double animationProgress);

class WeatherParticleAnimator extends StatelessWidget {
  const WeatherParticleAnimator({
    Key key,
    @required this.particleBuilder,
    @required this.axis,
    @required this.step,
    this.minAnimDuration = const Duration(seconds: 4),
    this.maxAnimDuration = const Duration(seconds: 6),
  })  : assert(minAnimDuration != null && maxAnimDuration != null ||
            minAnimDuration == null && maxAnimDuration == null),
        super(key: key);

  final ParticlePainterBuilder particleBuilder;
  final Axis axis;
  final double step;
  final Duration minAnimDuration;
  final Duration maxAnimDuration;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final particles = <Widget>[];
          final maxValue = axis == Axis.vertical
              ? constraints.maxWidth
              : constraints.maxHeight;
          for (var i = 0.0; i < maxValue; i += step) {
            particles.add(
              Padding(
                padding: axis == Axis.vertical
                    ? EdgeInsets.only(left: i)
                    : EdgeInsets.only(top: i),
                child: _Particle(
                  index: i ~/ step,
                  particleBuilder: particleBuilder,
                  minAnimDuration: minAnimDuration,
                  maxAnimDuration: maxAnimDuration,
                ),
              ),
            );
          }

          return Stack(
            alignment: Alignment.topLeft,
            children: particles,
          );
        },
      ),
    );
  }
}

class _Particle extends StatefulWidget {
  const _Particle({
    Key key,
    @required this.index,
    @required this.particleBuilder,
    @required this.minAnimDuration,
    @required this.maxAnimDuration,
  })  : assert(minAnimDuration <= maxAnimDuration),
        super(key: key);

  final int index;
  final ParticlePainterBuilder particleBuilder;
  final Duration minAnimDuration;
  final Duration maxAnimDuration;

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
    _initAnimController();
  }

  void _initAnimController() {
    _ctrl?.dispose();
    final durationDiff = widget.maxAnimDuration - widget.minAnimDuration;
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: widget.minAnimDuration.inMilliseconds +
              _rnd.nextInt(durationDiff.inMilliseconds + 1)),
    );
    _ctrl.repeat();
  }

  @override
  void didUpdateWidget(_Particle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.minAnimDuration != widget.minAnimDuration ||
        oldWidget.maxAnimDuration != widget.maxAnimDuration) {
      _initAnimController();
    }
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
          painter:
              widget.particleBuilder(widget.index, Colors.white, anim.value),
        ),
      ),
    );
  }
}
