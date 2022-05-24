import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';

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
        child: ContentGamePadButtonsContainer(),
      );
    });
  }
}

class ContentGamePadButtonsContainer extends StatefulWidget {
  ContentGamePadButtonsContainer({Key? key}) : super(key: key);

  @override
  State<ContentGamePadButtonsContainer> createState() =>
      _ContentGamePadButtonsContainerState();
}

class _ContentGamePadButtonsContainerState
    extends State<ContentGamePadButtonsContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePadAddButtonPositionCubit, Offset>(
      builder: (context, value) {
        if (value.dx == 0 && value.dy == 0) {
          return const Text("nada");
        }
        newButton(value);

        return Stack(children: buttons);
      },
    );
  }

  List<Widget> buttons = [];

  newButton(Offset position) {
    final cont = Container(
      width: 20,
      height: 20,
      color: Colors.black,
    );

    final ps = Positioned(
      child: cont,
      left: position.dx,
      top: position.dy,
    );
    buttons.add(ps);
  }
}
