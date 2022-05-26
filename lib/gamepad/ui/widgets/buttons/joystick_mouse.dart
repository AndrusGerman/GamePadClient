import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/joystick_base.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class JoystickMouseGamePad extends StatelessWidget {
  final ButtonViewScreenModel buttonData;
  JoystickMouseGamePad({
    Key? key,
    required this.buttonData,
  }) : super(key: key);

  _listenerPosition(StickDragDetails details) {
    bloc.sendSignalMouse(
        EventWSCreator(1, 1, ValueX: details.x, ValueY: details.y));
  }

  _onStickDragEnd() {
    bloc.sendSignalMouse(EventWSCreator(1, 3));
  }

  late ConnectionWS bloc;

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
          child: Container(
        width: joyStickAreaSize,
        height: joyStickAreaSize,
        child: jos,
      )),
    );

    return position;
  }
}
