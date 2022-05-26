import 'dart:async';

import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class GamePadAddButtonPositionBloc extends Bloc {
  List<ButtonViewScreen> listaData = [];

  sendButton(ButtonViewScreen value) {
    listaData.add(value);
    listDataController.add(listaData);
  }

  setAll(List<ButtonViewScreen> list) {
    listaData = list;
    listDataController.add(listaData);
  }

  final listDataController = StreamController<List<ButtonViewScreen>>();

  @override
  void dispose() {
    listDataController.close();
  }
}
