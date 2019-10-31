import 'package:flutter/material.dart';

class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton({
    this.id,
    this.text='xo',
    this.bg = Colors.grey,
    this.enabled = true
  });

}