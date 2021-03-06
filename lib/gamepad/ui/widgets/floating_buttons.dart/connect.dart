import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadModeBloc.dart';
import 'package:game_pad_client/gamepad/ui/widgets/floating_buttons.dart/floating_screen_button.dart';
import 'package:game_pad_client/ui/widgets/dialog.dart';
import 'package:game_pad_client/ui/widgets/modal.dart';
import 'package:game_pad_client/ui/widgets/snack_bar.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;
import 'package:game_pad_client/gamepad/repository/connect_ws.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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
    final wsbloc = gbloc.BlocProvider.of<ConnectionWS>(context);

    final defaultIP = await wsbloc.getIPDefault();
    final controller = TextEditingController(text: defaultIP);
    final stremEnableIP = StreamController<int>();

    // ignore: prefer_function_declarations_over_variables
    final connectAndClose = (ip) {
      // Connect and close
      isEnableIP(ip).then((resp) {
        if (resp != 200) {
          SnackBarGamePad(context).danger("No es posible conectarse");
          return;
        }
        SnackBarGamePad(context).success("Ping correcto");
        wsbloc.connect(ip);
        Navigator.pop(context);
        wsbloc.setIPDefault(ip);
      });
    };

    final streamCustomIP = StreamBuilder(
      initialData: 1,
      stream: stremEnableIP.stream,
      builder: (context, AsyncSnapshot<int?> snapshot) {
        final statusCode = snapshot.data ?? 1;

        if (statusCode == 1) {
          isEnableIP(controller.text).then((value) => stremEnableIP.add(value));
        }

        // set color connect button
        Color colorButton = Colors.blue;
        if (statusCode == 1) {
          colorButton = Colors.redAccent;
        }
        if (statusCode == 0) {
          colorButton = Colors.red;
        }

        final buttonConnect = ElevatedButton(
          onPressed: () {
            final ip = controller.text;
            connectAndClose(ip);
          },
          style: ElevatedButton.styleFrom(
            primary: colorButton,
          ),
          child: const Text("Conectar"),
        );

        return buttonConnect;
      },
    );

    final listView = ListView(
      children: [
        TextField(
          controller: controller,
          onChanged: (valuestr) {
            isEnableIP(valuestr).then((value) => stremEnableIP.add(value));
          },
        ),
        streamCustomIP,
        ElevatedButton(
          onPressed: () {
            connectAndClose("localhost");
          },
          style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
          child: const Text("Local (USB)"),
        )
      ],
    );

    // ignore: use_build_context_synchronously
    await CreateModal(context).bottomSheet(("IP: //"), listView);

    stremEnableIP.close();
  }

  Future<int> isEnableIP(String ip) async {
    final url = Uri.parse('http://$ip:8992/open');
    try {
      final response = await http.get(url);
      return response.statusCode;
    } catch (err) {
      return 0;
    }
  }
}
