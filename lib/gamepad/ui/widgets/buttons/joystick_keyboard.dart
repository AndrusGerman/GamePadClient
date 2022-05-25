import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class JoystickKeyboardGamePad extends StatelessWidget {
  final ButtonViewScreen buttonData;
  late void Function()? onTap;
  late void Function(TapUpDetails)? onTapUp;
  late void Function(TapDownDetails)? onTapDown;
  late void Function()? onTapCancel;

  JoystickKeyboardGamePad({
    Key? key,
    required this.buttonData,
    this.onTap,
    this.onTapUp,
    this.onTapCancel,
    this.onTapDown,
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

    final jos = Container(
        child: Joystick(
            mode: JoystickMode.all,
            period: Duration(milliseconds: 70),
            listener: listenerPosition,
            onStickDragEnd: onStickDragEnd));
    final containirSize = Container(
      width: sizeBox,
      height: sizeBox,
      alignment: Alignment.center,
      child: Center(
        child: jos,
      ),
    );

    final position = Positioned(
      left: buttonData.position.dx - (sizeBox / 2),
      top: buttonData.position.dy - (sizeBox / 2),
      child: GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onTap: onTap,
        child: containirSize,
      ),
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
