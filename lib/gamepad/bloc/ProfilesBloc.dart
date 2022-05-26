import 'dart:async';

import 'package:game_pad_client/gamepad/repository/models/profile.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfilesBloc extends Bloc {
  @override
  void dispose() {
    profiles.close();
  }

  List<ProfileModel> listProfiles = [];

  final profiles = StreamController<List<ProfileModel>>();

  addProfile(ProfileModel profile) {
    listProfiles.add(profile);
    profiles.add(listProfiles);
  }

  setProfiles(List<ProfileModel> setProfile) {
    listProfiles = setProfile;
    profiles.add(listProfiles);
  }
}
