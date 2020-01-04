import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

enum AnimationType { idle, rain }

class Cloud extends StatefulWidget {
  const Cloud({
    Key key,
    @required this.typeIndex,
    this.animationType = AnimationType.idle,
    this.minScale = 0.75,
    this.maxScale = 1.0,
    this.animationDuration = const Duration(seconds: 1),
    this.animationStartDelay = const Duration(),
    this.lightColor = Colors.white,
    this.darkColor = Colors.grey,
  }) : super(key: key);

  final int typeIndex;
  final AnimationType animationType;
  final Duration animationDuration;
  final Duration animationStartDelay;
  final double minScale;
  final double maxScale;
  final Color lightColor;
  final Color darkColor;

  @override
  _CloudState createState() => _CloudState();
}

class _CloudState extends State<Cloud> with SingleTickerProviderStateMixin {
  AnimationController _animCtrl;
  Animation<double> _scaleAnim;
  Animation<Color> _colorAnim;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _timer = Timer(widget.animationStartDelay, () {
      _animCtrl.repeat(reverse: true);
    });
    _initAnim();
  }

  void _initAnim() {
    assert(widget.animationType != null);
    switch (widget.animationType) {
      case AnimationType.idle:
        _colorAnim = kAlwaysDismissedAnimation.drive(
            ColorTween(begin: widget.lightColor, end: widget.lightColor));
        break;
      case AnimationType.rain:
        _colorAnim = _animCtrl
            .drive(ColorTween(begin: widget.lightColor, end: widget.darkColor));
        break;
    }
    _scaleAnim =
        _animCtrl.drive(Tween(begin: widget.minScale, end: widget.maxScale));
  }

  @override
  void didUpdateWidget(Cloud oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnim();
  }

  @override
  void dispose() {
    super.dispose();
    _animCtrl?.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.typeIndex < 4);

    return ScaleTransition(
      scale: _scaleAnim,
      child: AnimatedBuilder(
        animation: _colorAnim,
        builder: (context, _) => ColorFiltered(
          colorFilter: ColorFilter.mode(_colorAnim.value, BlendMode.modulate),
          child: FlareActor(
            'assets/__elements__.flr',
            artboard: 'cloud_${widget.typeIndex}',
          ),
        ),
      ),
    );
  }
}