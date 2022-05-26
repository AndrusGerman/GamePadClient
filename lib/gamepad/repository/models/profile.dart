import 'dart:convert';

import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';

class ProfileModel {
  late String name = "Por Defecto";
  late int id = 0;
  late List<ButtonViewScreenModel> buttons;

  String getJson() {
    List<String> buttonsStr = buttons.map((e) => e.getJson()).toList();
    final mapa = {
      'name': name,
      'buttons': buttonsStr,
      'id': id,
    };
    return jsonEncode(mapa);
  }

  setJson(String text) {
    final Map<String, dynamic> x = jsonDecode(text);

    name = x['name'] as String;

    try {
      id = x['id'] as int;
    } catch (err) {}

    final List<String> listStr =
        List<String>.from((x['buttons'] as List<dynamic>));

    buttons = listStr.map((e) {
      final bvsm = ButtonViewScreenModel();

      bvsm.setJson(e);
      return bvsm;
    }).toList();
  }
}
