import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/buttons/circle_button_raw.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class ButtonSimpleMouseGamePad extends StatelessWidget {
  final ButtonViewScreenModel buttonData;
  const ButtonSimpleMouseGamePad({Key? key, required this.buttonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final st = BlocProvider.of<GamePadModeCubit>(context);

    return StreamBuilder(
        builder: (context, AsyncSnapshot<GamePadModeIndex?> value) {
          if (GamePadModeIndex.values[value.data!.index] ==
              GamePadModeIndex.removeButtonsMode) {
            return createBtnRemove(context);
          }
          return createBtn(context);
        },
        initialData: GamePadModeIndex.playMode,
        stream: st.stream);
  }

  createBtn(BuildContext context) {
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

  createBtnRemove(BuildContext context) {
    final gpab = gbloc.BlocProvider.of<GamePadAddButtonPositionBloc>(context);

    return CircleButtonRaw(
      buttonData: buttonData,
      // Iniciar
      onTapUp: (details) {
        gpab.removeBtn(buttonData.id);
      },
      color: Color.fromARGB(255, 82, 230, 185),
    );
  }
}
