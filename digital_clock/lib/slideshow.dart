import 'dart:async';

import 'package:flutter/material.dart';

const _images = [
  'assets/summer_0.jpg',
  'assets/summer_1.jpg',
  'assets/summer_2.jpg',
];

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  Timer _timer;

  int _imgIndex = 0;
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      setState(() {
        _imgIndex = t.tick;
        _crossFadeState = t.tick % 2 == 0
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prevImagePath = _images[(_imgIndex - 1) % _images.length];
    final currentImagePath = _images[_imgIndex % _images.length];
    return AnimatedCrossFade(
      duration: const Duration(seconds: 2),
      crossFadeState: _crossFadeState,
      firstChild: SizedBox.expand(
        child: Image.asset(
          _imgIndex % 2 == 0 ? currentImagePath : prevImagePath,
          fit: BoxFit.cover,
        ),
      ),
      secondChild: SizedBox.expand(
        child: Image.asset(
          _imgIndex % 2 == 0 ? prevImagePath : currentImagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
