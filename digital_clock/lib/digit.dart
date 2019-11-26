import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Digit extends StatelessWidget {
  const Digit({
    Key key,
    @required this.digit,
    this.color,
    this.callback,
  }) : super(key: key);

  final int digit;
  final Color color;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey<int>(digit),
      child: FlareActor(
        'assets/numbers.flr',
        artboard: 'Anim',
        animation: '${(digit - 1) % 10} -> $digit',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        callback: callback,
        color: color,
      ),
    );
  }
}
