import 'package:digital_clock/clock.dart';
import 'package:digital_clock/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Foreground extends StatelessWidget {
  const Foreground({
    Key key,
    @required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight * 5 / 7;

      final c = Clock.of(context);

      final shaderCallback = (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: c.isDayTime
              ? [Colors.grey.shade400, Colors.grey.shade600]
              : [Colors.grey.shade800, Colors.grey.shade900],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      };

      final blendMode = BlendMode.modulate;

      return Transform.translate(
        offset: Offset(0, constraints.maxHeight - h),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: h * 0.1,
              width: w,
              height: h,
              child: ShaderMask(
                shaderCallback: shaderCallback,
                blendMode: blendMode,
                child: SvgPicture.asset(
                  'assets/mountains/m1.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: h * 0.2,
              width: w,
              height: h,
              child: ShaderMask(
                shaderCallback: shaderCallback,
                blendMode: blendMode,
                child: SvgPicture.asset(
                  'assets/mountains/m2.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: h * 0.4,
              width: w,
              height: h,
              child: ShaderMask(
                shaderCallback: shaderCallback,
                blendMode: blendMode,
                child: SvgPicture.asset(
                  'assets/mountains/m3.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: h * 0.5,
              width: w,
              height: h,
              child: ShaderMask(
                shaderCallback: shaderCallback,
                blendMode: blendMode,
                child: SvgPicture.asset(
                  'assets/mountains/m4.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: h * 0.6,
              width: w,
              height: h,
              child: ShaderMask(
                shaderCallback: shaderCallback,
                blendMode: blendMode,
                child: SvgPicture.asset(
                  'assets/mountains/m5.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
