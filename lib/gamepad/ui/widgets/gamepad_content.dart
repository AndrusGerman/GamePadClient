import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/button_simple.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_keyboard.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_mouse.dart';

class GamePadContentWidget extends StatelessWidget {
  const GamePadContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePadModeCubit, GamePadModeIndex>(
        builder: (context, value) {
      late MaterialColor color;
      if (value == GamePadModeIndex.playMode) {
        color = Colors.amber;
      }
      if (value == GamePadModeIndex.addButtonsMode) {
        color = Colors.blue;
      }
      if (value == GamePadModeIndex.removeButtonsMode) {
        color = Colors.red;
      }

      return Container(
        color: color,
        height: double.infinity,
        width: double.infinity,
        child: const ContentGamePadButtonsContainer(),
      );
    });
  }
}

class ContentGamePadButtonsContainer extends StatefulWidget {
  const ContentGamePadButtonsContainer({Key? key}) : super(key: key);

  @override
  State<ContentGamePadButtonsContainer> createState() =>
      _ContentGamePadButtonsContainerState();
}

class _ContentGamePadButtonsContainerState
    extends State<ContentGamePadButtonsContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePadAddButtonPositionCubit, ButtonViewScreen>(
      builder: (context, value) {
        print("Llego el boton $value");
        if (value.type == ButtonViewScreenType.nulo) {
          return const Center(
            child: Text("nada",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          );
        }
        newButton(value);

        return Stack(children: buttons);
      },
    );
  }

  List<Widget> buttons = [];

  newButton(ButtonViewScreen buttonData) {
    if (buttonData.type == ButtonViewScreenType.buttonSimple) {
      buttons.add(ButtonSimpleGamePad(buttonData: buttonData));
    }
    if (buttonData.type == ButtonViewScreenType.joystickMouse) {
      buttons.add(JoystickMouseGamePad(buttonData: buttonData));
    }

    if (buttonData.type == ButtonViewScreenType.joystickKeyboard) {
      buttons.add(JoystickKeyboardGamePad(buttonData: buttonData));
    }
  }
}
