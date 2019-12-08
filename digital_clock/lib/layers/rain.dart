import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const raindropStep = 16.0;
        final raindrops = <Widget>[];
        for (var x = 0.0; x < constraints.maxWidth; x += raindropStep) {
          raindrops.add(
            Padding(
              padding: EdgeInsets.only(left: x),
              child: Raindrop(index: x ~/ raindropStep),
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

class Raindrop extends StatefulWidget {
  const Raindrop({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  _RaindropState createState() => _RaindropState();
}

class _RaindropState extends State<Raindrop>
    with TickerProviderStateMixin<Raindrop> {
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
          painter: RaindropPainter(
            color: Colors.white,
            progress: anim.value,
          ),
        ),
      ),
    );
  }
}

const _raindropWidth = 8.0;
const _raindropHeight = _raindropWidth * 5;

class RaindropPainter extends CustomPainter {
  RaindropPainter({
    @required this.color,
    @required this.progress,
  });

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(1 - progress);
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
