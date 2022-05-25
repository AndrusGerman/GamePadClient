import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePadAddButtonPositionCubit extends Cubit<ButtonViewScreen> {
  GamePadAddButtonPositionCubit() : super(ButtonViewScreen());
  sendButton(ButtonViewScreen value) => emit(value);
}

class ButtonViewScreen {
  late Offset position;
  late double size;
  late ButtonViewScreenType type = ButtonViewScreenType.nulo;
  late int id;
  late List<String> codes;

  ButtonViewScreen setData(Offset position, double size,
      ButtonViewScreenType type, List<String> codes) {
    this.position = position;
    this.size = size;
    this.type = type;
    this.codes = codes;
    return this;
  }
}

enum ButtonViewScreenType { nulo, buttonSimple, joystickMouse }
