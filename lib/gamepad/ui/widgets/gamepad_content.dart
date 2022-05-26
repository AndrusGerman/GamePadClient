import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/button_mouse.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/button_simple.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_keyboard.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_mouse.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as provider;

class GamePadContentWidget extends StatelessWidget {
  const GamePadContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);

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
  Widget build(BuildContext context) {
    final gpap =
        provider.BlocProvider.of<GamePadAddButtonPositionBloc>(context);

    return StreamBuilder(
      builder: (context, AsyncSnapshot<List<dynamic>> value) {
        const nada = Center(
          child: Text("nada",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        );

        if (value.data == null) {
          return nada;
        }
        if (value.data!.isEmpty) {
          return nada;
        }

        // Lista de botones
        final wid = value.data!.map((e) => newButton(e)).toList();
        return Stack(children: wid);
      },
      stream: gpap.listDataController.stream,
    );
  }

  Widget newButton(ButtonViewScreen buttonData) {
    if (buttonData.type == ButtonViewScreenType.buttonSimple) {
      return (ButtonSimpleGamePad(buttonData: buttonData));
    }
    if (buttonData.type == ButtonViewScreenType.joystickMouse) {
      return (JoystickMouseGamePad(buttonData: buttonData));
    }

    if (buttonData.type == ButtonViewScreenType.joystickKeyboard) {
      return (JoystickKeyboardGamePad(buttonData: buttonData));
    }

    if (buttonData.type == ButtonViewScreenType.buttonMouse) {
      return (ButtonSimpleMouseGamePad(buttonData: buttonData));
    }
    return Container();
  }
}
