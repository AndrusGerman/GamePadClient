import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';

class ButtonSimpleGamePad extends StatelessWidget {
  final ButtonViewScreen buttonData;
  const ButtonSimpleGamePad({Key? key, required this.buttonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sizeBox = buttonData.size;
    final containirSize = Container(
      width: sizeBox,
      height: sizeBox,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black38,
          width: 2.3,
        ),
      ),
    );

    final position = Positioned(
      child: containirSize,
      left: buttonData.position.dx - (sizeBox / 2),
      top: buttonData.position.dy - (sizeBox / 2),
    );

    return position;
  }
}
