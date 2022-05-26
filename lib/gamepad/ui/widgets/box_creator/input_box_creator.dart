import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/get_button_code.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/get_size.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/get_type.dart';
import 'package:game_pad_client/ui/widgets/dialog.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as provider;

class InputBoxCreator {
  final TextEditingController controllerSize =
      TextEditingController(text: "50");
  late BuildContext primaryContext;
  late Offset position;

  displayDialog(BuildContext context, Offset position) {
    primaryContext = context;
    this.position = position;
    getType();
  }

  controllerSizeSetValue(String value) {
    controllerSize.value = controllerSize.value.copyWith(
        text: value, selection: TextSelection.collapsed(offset: value.length));
  }

  Future getSize(BuildContext context) async {
    final wid = BoxCreatorGetSize(
      controllerSize: controllerSize,
      controllerSizeSetValue: controllerSizeSetValue,
    );

    await CreateDialog(primaryContext)
        .openSimple(const Text("Tamaño del elemento"), wid);

    final value = controllerSize.text;
    if (value == "" || value == "0") {
      throw "Not valid";
    }
  }

  goToGetSize(ButtonViewScreenType type) {
    getSize(primaryContext).then((value) {
      generateButtonType(type);
    });
  }

  getType() {
    final dCtr = CreateDialog(primaryContext);
    final dialog = BoxCreatorGetType(
        controllerSizeSetValue: controllerSizeSetValue, goToSize: goToGetSize);
    dCtr.openSimple(const Text("¿Que tipo de boton agregaras?"), dialog);
  }

  generateButtonType(ButtonViewScreenType type) async {
    // Get Size
    final sizeButton = int.parse(controllerSize.text).toDouble();
    // Simple Button Generator
    if (type == ButtonViewScreenType.buttonSimple) {
      // Get Codes
      final response =
          (await GenerateCodesButton().generate(["principal"], primaryContext));

      // Generate button
      final button = ButtonViewScreenModel().setData(
        position,
        sizeButton,
        type,
        response,
      );

      // send
      provider.BlocProvider.of<GamePadAddButtonPositionBloc>(primaryContext)
          .sendButton(button);
    }

    // Simple Button Mouse
    if (type == ButtonViewScreenType.buttonMouse) {
      // Get Codes
      final response = (await GenerateCodesButton()
          .generate(["principal"], primaryContext, isMouse: true));

      // Generate button
      final button = ButtonViewScreenModel().setData(
        position,
        sizeButton,
        type,
        response,
      );

      // send
      provider.BlocProvider.of<GamePadAddButtonPositionBloc>(primaryContext)
          .sendButton(button);
    }

    // Simple Joystick Mouse
    if (type == ButtonViewScreenType.joystickMouse) {
      // Generate button
      final button = ButtonViewScreenModel().setData(
        position,
        sizeButton,
        type,
        [],
      );
      // send
      provider.BlocProvider.of<GamePadAddButtonPositionBloc>(primaryContext)
          .sendButton(button);
    }

    // Joystick Keyboard
    if (type == ButtonViewScreenType.joystickKeyboard) {
      // Get Codes
      final response = (await GenerateCodesButton().generate([
        "Arriba",
        "(<-) Izquierda",
        "(->) Derecha",
        "Abajo",
      ], primaryContext));

      // Generate button
      final button = ButtonViewScreenModel().setData(
        position,
        sizeButton,
        type,
        response,
      );
      // send
      provider.BlocProvider.of<GamePadAddButtonPositionBloc>(primaryContext)
          .sendButton(button);
    }
  }
}
