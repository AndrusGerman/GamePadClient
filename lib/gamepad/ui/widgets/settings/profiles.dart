import 'package:flutter/material.dart';
import 'package:game_pad_client/bloc/storage_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';

class ProfileSettingsGamePad extends StatelessWidget {
  final GamePadAddButtonPositionBloc gpab;
  final StorageBloc storageBloc;
  const ProfileSettingsGamePad(
      {Key? key, required this.gpab, required this.storageBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
