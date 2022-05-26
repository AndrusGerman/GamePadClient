import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageBloc extends Bloc {
  final SharedPreferences? storage;
  StorageBloc(this.storage);

  @override
  void dispose() {}
}
