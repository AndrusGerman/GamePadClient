import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';

class CircleButtonRaw extends StatelessWidget {
  final ButtonViewScreenModel buttonData;
  late void Function()? onTap;
  late void Function(TapUpDetails)? onTapUp;
  late void Function(TapDownDetails)? onTapDown;
  late void Function()? onTapCancel;
  Color color;

  CircleButtonRaw(
      {Key? key,
      required this.buttonData,
      this.onTap,
      this.onTapUp,
      this.onTapCancel,
      this.onTapDown,
      this.color = Colors.blueAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sizeBox = buttonData.size;
    final containirSize = Container(
      width: sizeBox,
      height: sizeBox,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black38,
          width: 2.3,
        ),
      ),
      child: Center(
        child: Text(buttonData.codes[0]),
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
