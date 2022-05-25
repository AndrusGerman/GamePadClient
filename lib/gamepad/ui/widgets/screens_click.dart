import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/ui/widgets/input_box_creator.dart';

class ScreenClickWidget extends StatelessWidget {
  final Widget child;
  ScreenClickWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return GestureDetector(
      onTapUp: (TapUpDetails details) => _onTapUp(details),
      child: child,
    );
  }

  addButtonIn(Offset value) {
    InputBoxCreator().displayDialog(context, value);
    return;
  }

  _onTapUp(TapUpDetails details) {
    final st = BlocProvider.of<GamePadModeCubit>(context).state;

    if (st == GamePadModeIndex.addButtonsMode) {
      addButtonIn(details.globalPosition);
    }
    return;
  }
}
