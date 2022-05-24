import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';

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
            icon: Icons.remove)
      ],
    );
  }
}

class FloatingScreenButtonButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  const FloatingScreenButtonButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.small(
        onPressed: onPressed,
        tooltip: 'Increment',
        child: Icon(icon),
      ),
    );
  }
}


 //  floatingActionButton: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: <Widget>[
    //       Align(
    //         alignment: Alignment.bottomRight,
    //         child: SizedBox(
    //           height: 40,
    //           width: 40,
    //           child: FloatingActionButton(
    //             onPressed: () {},
    //             tooltip: 'Increment',
    //             child: const Icon(Icons.add),
    //           ),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomRight,
    //         child: FloatingActionButton.small(
    //           onPressed: () {},
    //           tooltip: 'Increment',
    //           child: const Icon(Icons.add),
    //         ),
    //       ),
    //     ],
    //   ),