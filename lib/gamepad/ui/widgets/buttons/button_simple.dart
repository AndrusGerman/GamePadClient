import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/circle_button_raw.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class ButtonSimpleGamePad extends StatelessWidget {
  final ButtonViewScreenModel buttonData;
  const ButtonSimpleGamePad({Key? key, required this.buttonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);

    return CircleButtonRaw(
      buttonData: buttonData,
      // Iniciar
      onTapDown: (details) {
        bloc.sendSignal(EventWSCreator(2, 1, Value: buttonData.codes[0]));
      },
      // Cancelar
      onTapUp: (details) {
        bloc.sendSignal(EventWSCreator(2, 3, Value: buttonData.codes[0]));
      },
      onTapCancel: () {
        bloc.sendSignal(EventWSCreator(2, 3, Value: buttonData.codes[0]));
      },
    );
  }
}
