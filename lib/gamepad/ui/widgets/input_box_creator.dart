import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/types_buttons.dart';

class InputBoxCreator {
  final TextEditingController controllerSize =
      TextEditingController(text: "50");
  late BuildContext primaryContext;
  late Offset position;

  displayDialog(BuildContext context, Offset position) {
    primaryContext = context;
    this.position = position;
    getSize(context);
  }

  getSize(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Tamaño del boton"),
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
                      if (valueInt < 0 || valueInt > 390) {
                        controllerSize.value = controllerSize.value.copyWith(
                            text: "390",
                            selection:
                                TextSelection.collapsed(offset: "390".length));
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
                          getType(context);
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

  getType(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("¿Que tipo de boton agregaras?"),
            content: ListView(
              children: [
                InputListTipeButton(
                  onTap: () {
                    Navigator.pop(context);
                    generateButtonType(
                        ButtonViewScreenType.buttonSimple, context);
                  },
                  text: "Simple",
                ),
                InputListTipeButton(
                  onTap: () {},
                  text: "Example",
                ),
                InputListTipeButton(
                  onTap: () {},
                  text: "Example",
                ),
                InputListTipeButton(
                  text: "Cerrar",
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

  getButtonCode(BuildContext context, void Function(String code) callback) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("¿Cual es el boton que agregaras?"),
            content: SizedBox(
              height: 30,
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
                    child: Container(
                      child: Text("Guardar Personalizado"),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: ((context, index) {
                      final item = GetButtonsTypeRepository().data[index];
                      return ListTile(
                        title: Text(item.getName()),
                        onTap: () {
                          callback(item.getCode());
                        },
                      );
                    }),
                    itemCount: GetButtonsTypeRepository().data.length,
                  )
                ],
              ),
            ),
          );
        });
  }

  generateButtonType(ButtonViewScreenType type, BuildContext context) {
    // Get Size
    final valueInt = int.parse(controllerSize.text).toDouble();
    ButtonViewScreen button;

    // Simple Button Generator
    if (type == ButtonViewScreenType.buttonSimple) {
      // Get Codes
      getButtonCode(context, (code) {
        // Generate button
        button = ButtonViewScreen().setData(
          position,
          valueInt,
          type,
          [code],
        );

        // send
        BlocProvider.of<GamePadAddButtonPositionCubit>(primaryContext)
            .sendButton(button);
      });
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
