import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_base.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class JoystickKeyboardGamePad extends StatelessWidget {
  final ButtonViewScreenModel buttonData;

  JoystickKeyboardGamePad({
    Key? key,
    required this.buttonData,
  }) : super(key: key);

  covertInKeyboard(double x, y) {
    var keys = [];
    var keysRemove = [];

    // Down
    if (y >= 0.4) {
      keys.add(_position.down);
    } else {
      keysRemove.add(_position.down);
    }

    // Up
    if (y <= -0.4) {
      keys.add(_position.up);
    } else {
      keysRemove.add(_position.up);
    }

    // Left
    if (x >= 0.4) {
      keys.add(_position.left);
    } else {
      keysRemove.add(_position.left);
    }

    // Right
    if (x <= -0.4) {
      keys.add(_position.right);
    } else {
      keysRemove.add(_position.right);
    }

    return "${keys.join(',')}|${keysRemove.join(',')}";
  }

  _listenerPosition(StickDragDetails details) {
    final value = covertInKeyboard(details.x, details.y);
    bloc.sendSignal(EventWSCreator(6, 1, Value: value));
  }

  _onStickDragEnd() {
    bloc.sendSignal(EventWSCreator(6, 3, Value: allKeysJoin));
  }

  late ConnectionWS bloc;
  late PositionType _position;
  late String allKeysJoin;

  @override
  Widget build(BuildContext context) {
    final st = BlocProvider.of<GamePadModeCubit>(context);
    final gpab = gbloc.BlocProvider.of<GamePadAddButtonPositionBloc>(context);

    return StreamBuilder(
        builder: (context, AsyncSnapshot<GamePadModeIndex?> value) {
          final gamePadMode = GamePadModeIndex.values[value.data!.index];
          if (gamePadMode == GamePadModeIndex.removeButtonsMode) {
            return createJoystick(context, (eve) {
              gpab.removeBtn(buttonData.id);
            }, (eve) {});
          }
          // Is Normal
          return createJoystick(context, _listenerPosition, _onStickDragEnd);
        },
        initialData: GamePadModeIndex.playMode,
        stream: st.stream);
  }

  createJoystick(BuildContext context, listenerPosition, onStickDragEnd) {
    bloc = gbloc.BlocProvider.of<ConnectionWS>(context);
    final double sizeBox = buttonData.size;
    allKeysJoin = buttonData.codes.join(',');

    _position = PositionType(buttonData.codes[0], buttonData.codes[1],
        buttonData.codes[2], buttonData.codes[3]);

    final joyStickAreaSize = sizeBox * 1.3;

    final jos = JoystickArea(
      mode: JoystickMode.all,
      period: const Duration(milliseconds: 12),
      listener: listenerPosition,
      onStickDragEnd: onStickDragEnd,
      base: JoystickBaseGamePad(size: sizeBox),
    );

    final position = Positioned(
      left: buttonData.position.dx - (joyStickAreaSize / 2),
      top: buttonData.position.dy - (joyStickAreaSize / 2),
      child: SafeArea(
          child: SizedBox(
        width: joyStickAreaSize,
        height: joyStickAreaSize,
        child: jos,
      )),
    );
    return position;
  }
}

class PositionType {
  final String up;
  final String left;
  final String right;
  final String down;

  PositionType(this.up, this.right, this.left, this.down);
}
