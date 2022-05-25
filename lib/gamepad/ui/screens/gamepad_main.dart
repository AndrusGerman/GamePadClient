import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:game_pad_client/gamepad/ui/widgets/floating_screens.dart';
import 'package:game_pad_client/gamepad/ui/widgets/gamepad_content.dart';
import 'package:game_pad_client/gamepad/ui/widgets/screens_click.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

class GamePadUiMainScreen extends StatelessWidget {
  const GamePadUiMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConten = Scaffold(
      body: ScreenClickWidget(
        child: const GamePadContentWidget(),
      ),
      floatingActionButton: const FloatingScreensContainer(),
    );

    final laterBloc = gbloc.BlocProvider(
      bloc: ConnectionWS(),
      child: appConten,
    );

    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => GamePadModeCubit()),
      BlocProvider(create: (_) => GamePadAddButtonPositionCubit()),
    ], child: laterBloc);
  }
}
