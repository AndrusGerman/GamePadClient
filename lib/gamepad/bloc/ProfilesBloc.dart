import 'dart:async';

import 'package:game_pad_client/gamepad/repository/models/profile.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfilesBloc extends Bloc {
  @override
  void dispose() {
    profiles.close();
  }

  final profiles = StreamController<List<ProfileModel>>();
}
