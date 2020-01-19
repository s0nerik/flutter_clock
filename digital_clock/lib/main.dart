// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:digital_clock/clock.dart';
import 'package:digital_clock/playground.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

import 'digital_clock.dart';

void main() {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

//  runApp(
//    ClockCustomizer(
//      (ClockModel model) => ChangeNotifierProvider.value(
//        value: model,
//        child: Playground(),
//      ),
//    ),
//  );
//  return;

  runApp(
    ChangeNotifierProvider(
      create: (_) => Clock(),
      child: ClockCustomizer(
        (ClockModel model) => ChangeNotifierProvider.value(
          value: model,
          child: DigitalClock(),
        ),
      ),
    ),
  );
}
