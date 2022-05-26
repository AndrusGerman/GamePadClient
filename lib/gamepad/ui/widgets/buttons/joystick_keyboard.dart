import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
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
      keys.add(position.down);
    } else {
      keysRemove.add(position.down);
    }

    // Up
    if (y <= -0.4) {
      keys.add(position.up);
    } else {
      keysRemove.add(position.up);
    }

    // Left
    if (x >= 0.4) {
      keys.add(position.left);
    } else {
      keysRemove.add(position.left);
    }

    // Right
    if (x <= -0.4) {
      keys.add(position.right);
    } else {
      keysRemove.add(position.right);
    }

    return "${keys.join(',')}|${keysRemove.join(',')}";
  }

  listenerPosition(StickDragDetails details) {
    final value = covertInKeyboard(details.x, details.y);
    bloc.sendSignal(EventWSCreator(6, 1, Value: value));
  }

  onStickDragEnd() {
    bloc.sendSignal(EventWSCreator(6, 3, Value: allKeysJoin));
  }

  late ConnectionWS bloc;
  late _position position;
  late String allKeysJoin;

  @override
  Widget build(BuildContext context) {
    bloc = gbloc.BlocProvider.of<ConnectionWS>(context);
    final double sizeBox = buttonData.size;
    this.allKeysJoin = buttonData.codes.join(',');

    this.position = _position(buttonData.codes[0], buttonData.codes[1],
        buttonData.codes[2], buttonData.codes[3]);

    final joyStickAreaSize = sizeBox * 1.3;

    final jos = JoystickArea(
      mode: JoystickMode.all,
      period: Duration(milliseconds: 12),
      listener: listenerPosition,
      onStickDragEnd: onStickDragEnd,
      base: JoystickBaseGamePad(size: sizeBox),
    );

    final position = Positioned(
      left: buttonData.position.dx - (joyStickAreaSize / 2),
      top: buttonData.position.dy - (joyStickAreaSize / 2),
      child: SafeArea(
          child: Container(
        width: joyStickAreaSize,
        height: joyStickAreaSize,
        child: jos,
      )),
    );

    return position;
  }
}

class _position {
  final String up;
  final String left;
  final String right;
  final String down;

  _position(this.up, this.left, this.right, this.down);
}
