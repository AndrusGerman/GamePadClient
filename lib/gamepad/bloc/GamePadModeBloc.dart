import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePadModeCubit extends Cubit<GamePadModeIndex> {
  GamePadModeCubit() : super(GamePadModeIndex.playMode);
  void setMode(GamePadModeIndex mode) => emit(mode);

  @override
  void onChange(Change<GamePadModeIndex> change) {
    super.onChange(change);
  }
}

enum GamePadModeIndex { playMode, addButtonsMode, removeButtonsMode }
