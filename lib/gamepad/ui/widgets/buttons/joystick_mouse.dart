import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_base.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class JoystickMouseGamePad extends StatelessWidget {
  final ButtonViewScreen buttonData;
  JoystickMouseGamePad({
    Key? key,
    required this.buttonData,
  }) : super(key: key);

  listenerPosition(StickDragDetails details) {
    bloc.sendSignalMouse(
        EventWSCreator(1, 1, ValueX: details.x, ValueY: details.y));
  }

  onStickDragEnd() {
    bloc.sendSignalMouse(EventWSCreator(1, 3));
  }

  late ConnectionWS bloc;

  @override
  Widget build(BuildContext context) {
    bloc = gbloc.BlocProvider.of<ConnectionWS>(context);
    final double sizeBox = buttonData.size;

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
