import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:generic_bloc_provider/generic_bloc_provider.dart' as gbloc;
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionWS extends gbloc.Bloc {
  late SharedPreferences? prefs;
  ConnectionWS() {
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  @override
  void dispose() {
    isConnect.close();
    closeLastConnection();
    _timer?.cancel();
  }

  Future<String> getIPDefault() async {
    print("getIPDefault: 2");

    var dataIP = prefs?.getString("ip") ?? "192.168.101.16";

    print("getIPDefault: 3");

    return dataIP;
  }

  Future<void> setIPDefault(String ip) async {
    prefs?.setString("ip", ip);
  }

  autoConnect() async {
    return;
    _timer ??= Timer.periodic(const Duration(seconds: 3), (t) async {
      if (_isConnectBl == false) {
        var dataIP = await getIPDefault();
        connect(dataIP);
      }
    });
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
  late Timer? _timer = null;
  late bool _isConnectBl = false;

  IOWebSocketChannel? channel = null;
  WebSocket? ws = null;

  void connect(String ip) async {
    await closeLastConnection();
    print("Intenta conectar a $ip | 'ws://$ip:8992/ws'");
    ws = await WebSocket.connect('ws://$ip:8992/ws')
        .timeout(const Duration(seconds: 7));

    print("Intenta conectar paso 2");
    isConnect.add(true);
    _isConnectBl = true;

    // Set config
    ws!.listen((event) {
      print("In_isConnectBlicia todo");
    }, onError: (event) {
      print("No se pudo conectar");
    }, onDone: () {
      print("finish Close");
      isConnect.add(false);
      _isConnectBl = false;
    }, cancelOnError: true);

    // Create channel
    channel = IOWebSocketChannel(ws!);
  }

  sendSignal(EventWSCreator salida) {
    if (channel != null) {
      channel!.sink.add(salida.json());
    } else {
      isConnect.add(false);
      _isConnectBl = false;
    }
  }

  sendSignalMouse(EventWSCreator salida) {
    if (channel != null) {
      channel!.sink.add(salida.jsonMouse());
    } else {
      isConnect.add(false);
      _isConnectBl = false;
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
