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
              connectWS(context);
              // Play Mode
              BlocProvider.of<GamePadModeCubit>(context)
                  .setMode(GamePadModeIndex.playMode);
            },
            icon: Icons.connected_tv,
            color: color);

        return connect;
      }),
      initialData: false,
      stream: bloc.isConnect.stream,
    );
  }

  connectWS(BuildContext context) async {
    final bloc = gbloc.BlocProvider.of<ConnectionWS>(context);

    final defaultIP = await bloc.getIPDefault();
    final controller = TextEditingController(text: defaultIP);

    await showDialog(
        builder: (context) {
          final alerDial = AlertDialog(
              title: const Text("IP: //"),
              content: ListView(
                children: [
                  TextField(
                    controller: controller,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final ip = controller.text;
                      if (ip == "") {
                        return;
                      }
                      Navigator.pop(context);
                      bloc.setIPDefault(ip);

                      // Intenta Conectar,
                      bloc.connect(ip);
                    },
                    child: const Text("Conectar"),
                  )
                ],
              ));

          return alerDial;
        },
        context: context);
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