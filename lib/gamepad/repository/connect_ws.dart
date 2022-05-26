import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionWS extends gbloc.Bloc {
  final SharedPreferences? prefs;
  ConnectionWS(this.prefs) {
    ws = null;
    channel = null;
  }

  @override
  void dispose() {
    isConnect.close();
    closeLastConnection();
  }

  Future<String> getIPDefault() async {
    var dataIP = prefs?.getString("ip") ?? "192.168.101.16";
    return dataIP;
  }

  Future<void> setIPDefault(String ip) async {
    prefs?.setString("ip", ip);
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

  IOWebSocketChannel? channel;
  WebSocket? ws;

  void connect(String ip) async {
    await closeLastConnection();
    ws = await WebSocket.connect('ws://$ip:8992/ws')
        .timeout(const Duration(seconds: 7));

    isConnect.add(true);

    // Set config
    ws!.listen((event) {}, onError: (event) {}, onDone: () {
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

  sendSignalMouse(EventWSCreator salida) {
    if (channel != null) {
      channel!.sink.add(salida.jsonMouse());
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
  final double ValueX;
  final double ValueY;
  EventWSCreator(this.Type, this.Mode,
      {this.Value = "", this.ValueX = 0, this.ValueY = 0});

  String json() {
    return jsonEncode({
      'Type': Type,
      'Value': Value,
      'Mode': Mode,
    });
  }

  String jsonMouse() {
    return jsonEncode({
      'Type': Type,
      'Mode': Mode,
      'ValueX': ValueX,
      'ValueY': ValueY,
    });
  }
}
