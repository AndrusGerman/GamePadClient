import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePadAddButtonPositionCubit extends Cubit<Offset> {
  GamePadAddButtonPositionCubit() : super(const Offset(0, 0));
  setPosition(Offset value) => emit(value);
}
