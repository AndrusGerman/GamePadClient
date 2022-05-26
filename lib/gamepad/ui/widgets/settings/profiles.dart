import 'package:flutter/material.dart';
import 'package:game_pad_client/bloc/storage_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/ProfilesBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/profile.dart';
import 'package:game_pad_client/gamepad/repository/profiles_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileSettingsGamePad extends StatefulWidget {
  final GamePadAddButtonPositionBloc gpab;
  final StorageBloc storageBloc;
  const ProfileSettingsGamePad(
      {Key? key, required this.gpab, required this.storageBloc})
      : super(key: key);

  @override
  State<ProfileSettingsGamePad> createState() => _ProfileSettingsGamePadState();
}

class _ProfileSettingsGamePadState extends State<ProfileSettingsGamePad> {
  final profileName = TextEditingController(text: "Perfil Por Defecto");

  @override
  Widget build(BuildContext context) {
    final repo = ProfileRepository(widget.storageBloc.storage!);
    final blocProfiles = BlocProvider.of<ProfilesBloc>(context);
    blocProfiles.setProfiles(repo.getProfiles());
    return ListView(
      children: [
        TextField(
          controller: profileName,
        ),
        ElevatedButton(
            onPressed: () {
              final newProfile =
                  repo.generateProfile(profileName.text, widget.gpab.listaData);
              blocProfiles.addProfile(newProfile);

              repo.saveProfiles(blocProfiles.listProfiles);
            },
            child: const Text("Guardar Perfil")),
        StreamBuilder(
          builder: ((context, AsyncSnapshot<List?> snapshot) {
            if (snapshot.data!.isEmpty) {
              return Text("Sin perfiles disponibles...");
            }
            // List Profiles
            final profiles =
                snapshot.data!.map((e) => _ProfilesTiles(profile: e)).toList();

            return Column(
              children: profiles,
            );
          }),
          initialData: [],
          stream: blocProfiles.profiles.stream,
        )
      ],
    );
  }

  @override
  void dispose() {
    this.profileName.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

class _ProfilesTiles extends StatelessWidget {
  final ProfileModel profile;
  const _ProfilesTiles({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(profile.name),
    );
  }
}
