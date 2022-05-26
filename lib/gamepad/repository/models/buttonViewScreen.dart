import 'dart:convert';

import 'package:flutter/material.dart';

class ButtonViewScreenModel {
  late Offset position = Offset.zero;
  late double size = 0;
  late ButtonViewScreenType type;
  late int id = 0;
  late List<String> codes = [];

  ButtonViewScreenModel setData(Offset position, double size,
      ButtonViewScreenType type, List<dynamic> codes) {
    this.position = position;
    this.size = size;
    this.type = type;
    this.codes = codes.map((e) => e.toString()).toList();
    return this;
  }

  String asJsonString() {
    final map = {
      'position': {'x': position.dx, 'y': position.dy},
      'size': size,
      'type': type.index,
      'id': id,
      'codes': codes,
    };

    return jsonEncode(map);
  }

  setDataByJSON(String data) {
    final Map<String, dynamic> mapa = jsonDecode(data);
    final Map<String, dynamic> positionRaw = mapa['position'];

    position = Offset(positionRaw['x'] as double, positionRaw['y'] as double);
    size = mapa['size'] as double;
    final rawType = mapa['type'] as int;
    type = ButtonViewScreenType.values[rawType];
    id = mapa['id'] as int;
    codes = mapa['codes'] as List<String>;
  }
}

enum ButtonViewScreenType {
  buttonSimple,
  joystickMouse,
  joystickKeyboard,
  buttonMouse,
}
