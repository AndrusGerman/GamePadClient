import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/bloc/storage_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/ui/widgets/floating_buttons.dart/connect.dart';
import 'package:game_pad_client/gamepad/ui/widgets/floating_buttons.dart/floating_screen_button.dart';
import 'package:game_pad_client/gamepad/ui/widgets/settings/view_list_simple_settings.dart';
import 'package:game_pad_client/ui/widgets/dialog.dart';
import 'package:game_pad_client/ui/widgets/modal.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as provider;

class FloatingScreensContainer extends StatelessWidget {
  const FloatingScreensContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //GamePadModeCubit()
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Play Mode
        FloatingScreenButtonButton(
            onPressed: () {
              BlocProvider.of<GamePadModeCubit>(context)
                  .setMode(GamePadModeIndex.playMode);
            },
            icon: Icons.play_arrow),

        // Add Mode
        FloatingScreenButtonButton(
            onPressed: () {
              BlocProvider.of<GamePadModeCubit>(context)
                  .setMode(GamePadModeIndex.addButtonsMode);
            },
            icon: Icons.add),
        // Remove Mode
        FloatingScreenButtonButton(
            onPressed: () {
              BlocProvider.of<GamePadModeCubit>(context)
                  .setMode(GamePadModeIndex.removeButtonsMode);
            },
            icon: Icons.remove),
        // Connect
        const ConnectButtonBuilder(),

        FloatingScreenButtonButton(
            onPressed: () {
              final gpap =
                  provider.BlocProvider.of<GamePadAddButtonPositionBloc>(
                      context);

              final storageBloc =
                  provider.BlocProvider.of<StorageBloc>(context);

              CreateModal(context).bottomSheet(const Text("Settings"),
                  ViewListSimpleSettings(gpab: gpap, storageBloc: storageBloc));
            },
            icon: Icons.settings),
      ],
    );
  }
}
