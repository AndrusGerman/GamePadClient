import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/ui/widgets/box_creator/box_creator_input.dart';

class BoxCreatorGetType extends StatelessWidget {
  final Function(ButtonViewScreenType) goToSize;
  final void Function(String) controllerSizeSetValue;
  const BoxCreatorGetType(
      {Key? key, required this.goToSize, required this.controllerSizeSetValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ListView(
      children: [
        BoxCreatorInputListTipeButton(
          onTap: () {
            Navigator.pop(context);
            goToSize(ButtonViewScreenType.buttonSimple);
          },
          text: "Simple (Button)",
        ),
        BoxCreatorInputListTipeButton(
          onTap: () {
            Navigator.pop(context);
            goToSize(ButtonViewScreenType.buttonMouse);
          },
          text: "Simple (Button Mouse)",
        ),
        BoxCreatorInputListTipeButton(
          onTap: () {
            controllerSizeSetValue("120");
            Navigator.pop(context);
            goToSize(ButtonViewScreenType.joystickMouse);
          },
          text: "Mouse (joystick)",
        ),
        BoxCreatorInputListTipeButton(
          onTap: () {
            controllerSizeSetValue("120");
            Navigator.pop(context);
            goToSize(ButtonViewScreenType.joystickKeyboard);
          },
          text: "Keyboard (joystick)",
        ),
        BoxCreatorInputListTipeButton(
          text: "**Cerrar**",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    return list;
  }
}
