import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class GamePadAddButtonPositionBloc extends Bloc {
  List<ButtonViewScreen> listaData = [];

  sendButton(ButtonViewScreen value) {
    print("1:Emitir");
    listaData.add(value);
    listDataController.add(listaData);
    print("2:Fin de emitir");
  }

  final listDataController = StreamController<List<ButtonViewScreen>>();

  @override
  void dispose() {
    listDataController.close();
  }
}

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
}

enum ButtonViewScreenType {
  buttonSimple,
  joystickMouse,
  joystickKeyboard,
  buttonMouse,
}
