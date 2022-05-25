import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';

class JoystickMouseGamePad extends StatelessWidget {
  final ButtonViewScreen buttonData;
  late void Function()? onTap;
  late void Function(TapUpDetails)? onTapUp;
  late void Function(TapDownDetails)? onTapDown;
  late void Function()? onTapCancel;

  JoystickMouseGamePad({
    Key? key,
    required this.buttonData,
    this.onTap,
    this.onTapUp,
    this.onTapCancel,
    this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sizeBox = buttonData.size;

    final jos = Container(
        child: Joystick(mode: JoystickMode.all, listener: ((details) {})));
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
