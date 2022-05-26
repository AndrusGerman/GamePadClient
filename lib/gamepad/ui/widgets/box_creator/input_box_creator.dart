import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/get_button_code.dart';
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
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Tamaño del elemento"),
            content: Container(
              // height: 0,
              // width: double.infinity,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      // Ignore change
                      if (value == "") {
                        return;
                      }
                      // Set Max and min value
                      final valueInt = int.parse(value).toInt();
                      if (valueInt < 0 || valueInt > 390) {
                        controllerSizeSetValue("390");
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: controllerSize,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (controllerSize.text != "") {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        child: Text("Guardar"),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        controllerSize.clear();
                      },
                      child: Container(
                        child: Text("Cancelar"),
                      ))
                ],
              ),
            ),
          );
        });

    final value = controllerSize.text;
    if (value == "" || value == "0") {
      throw "Not valid";
    }
  }

  getType() {
    showDialog(
        context: primaryContext,
        builder: (context) {
          return AlertDialog(
            title: const Text("¿Que tipo de boton agregaras?"),
            content: ListView(
              children: [
                InputListTipeButton(
                  onTap: () {
                    Navigator.pop(context);
                    getSize(primaryContext).then((value) {
                      generateButtonType(ButtonViewScreenType.buttonSimple);
                    });
                  },
                  text: "Simple (Button)",
                ),
                InputListTipeButton(
                  onTap: () {
                    Navigator.pop(context);
                    getSize(primaryContext).then((value) {
                      generateButtonType(ButtonViewScreenType.buttonMouse);
                    });
                  },
                  text: "Simple (Button Mouse)",
                ),
                InputListTipeButton(
                  onTap: () {
                    Navigator.pop(context);
                    controllerSizeSetValue("120");
                    getSize(primaryContext).then((value) {
                      generateButtonType(ButtonViewScreenType.joystickMouse);
                    });
                  },
                  text: "Mouse (joystick)",
                ),
                InputListTipeButton(
                  onTap: () {
                    Navigator.pop(context);
                    controllerSizeSetValue("120");
                    getSize(primaryContext).then((value) {
                      generateButtonType(ButtonViewScreenType.joystickKeyboard);
                    });
                  },
                  text: "Keyboard (joystick)",
                ),
                InputListTipeButton(
                  text: "**Cerrar**",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
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
      final button = ButtonViewScreen().setData(
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
      final button = ButtonViewScreen().setData(
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
      final button = ButtonViewScreen().setData(
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
      final button = ButtonViewScreen().setData(
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

class InputListTipeButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const InputListTipeButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: onTap,
    );
  }
}
