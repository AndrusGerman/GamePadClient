import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/types_buttons.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/get_button_code.dart';

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
            content: SizedBox(
              height: 110,
              width: double.infinity,
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
                      if (valueInt < 30 || valueInt > 390) {
                        controllerSizeSetValue("390");
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: controllerSize,
                  ),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.save))
                  ElevatedButton(
                      onPressed: () {
                        if (controllerSize.text != "") {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        child: Text("Guardar"),
                      ))
                ],
              ),
            ),
          );
        });
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
                      generateButtonType(ButtonViewScreenType.joystickMouse);
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

  final TextEditingController controllerCustom =
      TextEditingController(text: "");

  getButtonCodex(BuildContext context, void Function(String code) callback) {
    final repository = GetButtonsTypeRepository();
    showDialog(
        context: primaryContext,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "¿Cual es el boton que agregaras? ${repository.data.length}"),
            content: SizedBox(
              height: 270,
              width: double.infinity,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.text,
                    controller: controllerCustom,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controllerCustom.text != "") {
                        Navigator.pop(context);
                        callback(controllerCustom.text);
                      }
                    },
                    child: const Text("Guardar Personalizado"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getButtonCodexdd(void Function(String code) callback) {
    final repository = GetButtonsTypeRepository();

    final listViewItems = ListView.builder(
        itemBuilder: (contextBuilder, index) {
          final itemRepo = repository.data[index];

          final item = ListTile(
            title: Text(itemRepo.getName()),
            onTap: () {
              Navigator.pop(contextBuilder);
              callback(itemRepo.getCode());
            },
          );

          if (index == 0) {
            return CustomAdd(
                controllerCustom: controllerCustom,
                //callback: callback,
                item: item);
          }

          return item;
        },
        itemCount: repository.data.length);

    showDialog(
        context: primaryContext,
        builder: (context) {
          return AlertDialog(
            title: const Text("¿Cual es el boton que agregaras?"),
            content: SizedBox(
              height: 270,
              width: double.infinity,
              child: listViewItems,
            ),
          );
        });
  }

  generateButtonType(ButtonViewScreenType type) async {
    // Get Size
    final sizeButton = int.parse(controllerSize.text).toDouble();
    // Simple Button Generator
    if (type == ButtonViewScreenType.buttonSimple) {
      print("Aqui se crea la magia");
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
      BlocProvider.of<GamePadAddButtonPositionCubit>(primaryContext)
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
      BlocProvider.of<GamePadAddButtonPositionCubit>(primaryContext)
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
