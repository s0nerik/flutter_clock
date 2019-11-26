// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';

import 'package:digital_clock/digit.dart';
import 'package:digital_clock/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
//      _timer = Timer(
//        Duration(minutes: 1) -
//            Duration(seconds: _dateTime.second) -
//            Duration(milliseconds: _dateTime.millisecond),
//        _updateTime,
//      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    final digits = <int>[
      int.parse(hour[0]),
      int.parse(hour[1]),
      int.parse(minute[0]),
      int.parse(minute[1]),
      int.parse(second[0]),
      int.parse(second[1]),
    ];

    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final digitWidth = constraints.maxWidth / 8;
            final digitHeight = 100.0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: digitWidth,
                  height: digitHeight,
                  child: Digit(digit: digits[0]),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: digitWidth,
                  height: digitHeight,
                  child: Digit(digit: digits[1]),
                ),
                SizedBox(
                  width: digitWidth,
                  height: digitHeight,
                  child: Ticker(),
                ),
                SizedBox(
                  width: digitWidth,
                  height: digitHeight,
                  child: Digit(digit: digits[2]),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: digitWidth,
                  height: digitHeight,
                  child: Digit(digit: digits[3]),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: digitWidth / 2,
                  height: digitHeight / 2,
                  child: Digit(digit: digits[4]),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: digitWidth / 2,
                  height: digitHeight / 2,
                  child: Digit(digit: digits[5]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
