import 'dart:convert';

import 'package:flutter/material.dart';

class ButtonViewScreen {
  late Offset position;
  late double size;
  late ButtonViewScreenType type;
  late int id;
  late List<String> codes;

  ButtonViewScreen setData(Offset position, double size,
      ButtonViewScreenType type, List<dynamic> codes) {
    this.position = position;
    this.size = size;
    this.type = type;
    this.codes = codes.map((e) => e.toString()).toList();
    return this;
  }

  asJsonString() {}
}

enum ButtonViewScreenType {
  buttonSimple,
  joystickMouse,
  joystickKeyboard,
  buttonMouse,
}
