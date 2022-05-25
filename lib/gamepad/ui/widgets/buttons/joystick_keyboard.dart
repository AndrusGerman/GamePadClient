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

  listenerPosition(StickDragDetails details) {
    bloc.sendSignalMouse(
        EventWSCreator(1, 1, ValueX: details.x, ValueY: details.y));
  }

  onStickDragEnd() {
    bloc.sendSignalMouse(EventWSCreator(1, 3));
  }

  late ConnectionWS bloc;
  late _position position;

  @override
  Widget build(BuildContext context) {
    bloc = gbloc.BlocProvider.of<ConnectionWS>(context);
    final double sizeBox = buttonData.size;

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