import 'dart:async';

import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class GamePadAddButtonPositionBloc extends Bloc {
  List<ButtonViewScreenModel> listaData = [];

  sendButton(ButtonViewScreenModel value) {
    listaData.add(value);
    listDataController.add(listaData);
  }

  setAll(List<ButtonViewScreenModel> list) {
    listaData = list;
    listDataController.add(listaData);
  }

  final listDataController = StreamController<List<ButtonViewScreenModel>>();

  @override
  void dispose() {
    listDataController.close();
  }
}
