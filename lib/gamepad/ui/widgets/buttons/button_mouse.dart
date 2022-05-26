import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/repository/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/circle_button_raw.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class ButtonSimpleMouseGamePad extends StatelessWidget {
  final ButtonViewScreen buttonData;
  const ButtonSimpleMouseGamePad({Key? key, required this.buttonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);

    return CircleButtonRaw(
      buttonData: buttonData,
      // Iniciar
      onTapDown: (details) {
        bloc.sendSignal(EventWSCreator(3, 1, Value: buttonData.codes[0]));
      },
      // Cancelar
      onTapUp: (details) {
        bloc.sendSignal(EventWSCreator(3, 3, Value: buttonData.codes[0]));
      },
      onTapCancel: () {
        bloc.sendSignal(EventWSCreator(3, 3, Value: buttonData.codes[0]));
      },
      color: Color.fromARGB(255, 82, 230, 185),
    );
  }
}
