import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;

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
        ConnectButtonBuilder(),
      ],
    );
  }
}

class ConnectButtonBuilder extends StatefulWidget {
  const ConnectButtonBuilder({Key? key}) : super(key: key);

  @override
  State<ConnectButtonBuilder> createState() => _ConnectButtonBuilderState();
}

class _ConnectButtonBuilderState extends State<ConnectButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);

    return StreamBuilder(
      builder: ((context, AsyncSnapshot<bool?> snapshot) {
        final color = (snapshot.data!) ? Colors.white : Colors.red;

        final connect = FloatingScreenButtonButton(
            onPressed: () {
              final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);
              bloc.connect("192.168.101.16");
            },
            icon: Icons.connected_tv,
            color: color);

        return connect;
      }),
      initialData: false,
      stream: bloc.isConnect.stream,
    );
  }
}

class FloatingScreenButtonButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final Color color;
  const FloatingScreenButtonButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.small(
        onPressed: onPressed,
        tooltip: 'Increment',
        child: Icon(
          icon,
          color: color,
        ),
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