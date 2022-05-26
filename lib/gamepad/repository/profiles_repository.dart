import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
import 'package:game_pad_client/gamepad/repository/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;

class ProfileRepository {
  final SharedPreferences prefs;
  ProfileRepository(this.prefs);

  saveProfiles(List<ProfileModel> list) {
    final profilesStr = list.map((e) => e.getJson()).toList();

    prefs.setStringList('profiles', profilesStr);
  }

  ProfileModel generateProfile(
      String name, List<ButtonViewScreenModel> buttons) {
    final profile = ProfileModel();
    profile.name = name;
    profile.buttons = buttons;
    profile.id = DateTime.now().microsecondsSinceEpoch;
    return profile;
  }

  List<ProfileModel> getProfiles() {
    final profilesStr = prefs.getStringList('profiles') ?? [];

    final profiles = profilesStr.map((e) {
      final profile = ProfileModel();
      profile.setJson(e);
      return profile;
    });

    return profiles.toList();
  }
}
