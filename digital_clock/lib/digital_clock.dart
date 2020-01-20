import 'package:digital_clock/clock.dart';
import 'package:digital_clock/layers/digits.dart';
import 'package:digital_clock/layers/mountains.dart';
import 'package:digital_clock/layers/sky.dart';
import 'package:digital_clock/layers/sky_gradient.dart';
import 'package:digital_clock/layers/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

class DigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(const []);

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SkyGradient(),
        Sky(),
        Transform.scale(
          scale: 1.01,
          child: Transform.translate(
            offset: Offset(0, h * 0.08),
            child: Mountains(),
          ),
        ),
        Container(
          height: h / 2,
          child: Weather(
            weatherCondition: ClockExtra.of(context).weatherCondition,
          ),
        ),
        _TimeSection(h: h, w: w),
      ],
    );
  }
}

class _TimeSection extends StatelessWidget {
  const _TimeSection({
    Key key,
    @required this.h,
    @required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    final isDayTime = Clock.of(context).isDayTime;
    final textColor = Colors.white;
    final bottomTextStyle = TextStyle(
      color: textColor,
      fontSize: 26,
      fontFamily: 'Comfortaa',
    );

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isDayTime ? Colors.black : Colors.white,
        BlendMode.modulate,
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: h / 2.2,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                SizedBox(
                  height: h / 4,
                  child: Digits(digitColor: textColor),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 2),
                  child: Row(
                    textBaseline: TextBaseline.ideographic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Icon(Mdi.calendarMonth, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          DateFormat('EEEE, MMMM d')
                              .format(Clock.of(context).now),
                          style: bottomTextStyle,
                        ),
                      ),
                      Icon(Mdi.thermometer, color: Colors.white),
                      SizedBox(width: 2),
                      Text(
                        ClockExtra.of(context).temperatureString,
                        style: bottomTextStyle,
                      ),
                      SizedBox(width: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
