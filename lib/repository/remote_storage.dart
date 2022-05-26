import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RemoteStorageRepository {
  final SharedPreferences prefs;
  RemoteStorageRepository(this.prefs);

  setData(String data) {}

  Future<String> getData() async {
    return "";
  }
}
