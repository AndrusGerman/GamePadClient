import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;
import 'package:web_socket_channel/io.dart';

class ConnectionWS extends gbloc.Bloc {
  @override
  void dispose() {
    isConnect.close();
    closeLastConnection();
  }

  closeLastConnection() async {
    if (ws != null) {
      await ws?.close();
    }
    if (channel != null) {
      await channel?.sink.close();
    }
  }

  final isConnect = StreamController<bool>();

  IOWebSocketChannel? channel = null;
  WebSocket? ws = null;

  void connect(String ip) async {
    await closeLastConnection();
    ws = await WebSocket.connect('ws://$ip:1323/ws')
        .timeout(const Duration(seconds: 5));
    isConnect.add(true);
    // Set config
    ws!.listen((event) {
      print("Inicia todo");
    }, onError: (event) {
      print("No se pudo conectar");
    }, onDone: () {
      print("finish Close");
      isConnect.add(false);
    }, cancelOnError: true);

    // Create channel
    channel = IOWebSocketChannel(ws!);
  }

  sendSignal(EventWSCreator salida) {
    if (channel != null) {
      channel!.sink.add(salida.json());
    } else {
      isConnect.add(false);
    }
  }

  void sendData() {}
}

class EventWSCreator {
  final int Type;
  final String Value;
  final int Mode;
  EventWSCreator(this.Type, this.Value, this.Mode);

  String json() {
    return jsonEncode({
      'Type': Type,
      'Value': Value,
      'Mode': Mode,
    });
  }
}
