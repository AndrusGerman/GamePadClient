import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_pad_client/bloc/storage_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/ProfilesBloc.dart';
import 'package:game_pad_client/gamepad/repository/models/buttonViewScreen.dart';
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
  final profileNameFocus = FocusNode();
  selectProfile(List<ButtonViewScreenModel> buttons) {
    widget.gpab.setAll(buttons);
  }

  createProfile() {
    // storage
    final repo = ProfileRepository(widget.storageBloc.storage!);
    final blocProfiles = BlocProvider.of<ProfilesBloc>(context);

    // add profile
    final newProfile =
        repo.generateProfile(profileName.text, widget.gpab.listaData);
    blocProfiles.addProfile(newProfile);

    // save
    repo.saveProfiles(blocProfiles.listProfiles);

    setDefaultText(blocProfiles.listProfiles);
  }

  setDefaultText(List<ProfileModel> listProfiles) {
    // set state
    formField.currentState?.setState(() {
      setText("Perfil ${listProfiles.length}");
    });
  }

  removeProfile(int idProfile) {
    // storage
    final repo = ProfileRepository(widget.storageBloc.storage!);
    final blocProfiles = BlocProvider.of<ProfilesBloc>(context);
    final listProfile = repo.getProfiles();

    // get Remove Element
    final indexRemove =
        listProfile.indexWhere((element) => element.id == idProfile);

    // remove
    listProfile.removeAt(indexRemove);

    // save
    blocProfiles.setProfiles(listProfile);
    repo.saveProfiles(blocProfiles.listProfiles);

    // change input
    setDefaultText(blocProfiles.listProfiles);
  }

  final formField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final repo = ProfileRepository(widget.storageBloc.storage!);
    final blocProfiles = BlocProvider.of<ProfilesBloc>(context);
    blocProfiles.setProfiles(repo.getProfiles());

    final textFiled = FormField(builder: (state) {
      return TextFormField(
        controller: profileName,
        focusNode: profileNameFocus,
      );
    });
    return ListView(
      children: [
        Form(child: textFiled, key: formField),
        ElevatedButton(
          onPressed: () {
            createProfile();
          },
          child: const Text("Guardar Perfil"),
        ),
        StreamBuilder(
          builder: ((context, AsyncSnapshot<List?> snapshot) {
            profileNameFocus.unfocus();
            if (snapshot.data!.isEmpty) {
              setText("Perfil Por Defecto");
              return const Text("Sin perfiles disponibles...");
            }
            // List Profiles
            final profiles = snapshot.data!
                .map((e) => _ProfilesTiles(
                      profile: e,
                      clickProfile: selectProfile,
                      removeProfile: removeProfile,
                    ))
                .toList();

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
    profileName.dispose();
    super.dispose();
  }

  _controllerSet(String value) {
    profileName.value = profileName.value.copyWith(
        text: value, selection: TextSelection.collapsed(offset: value.length));
  }

  setText(String value) {
    _controllerSet(value);
  }
}

class _ProfilesTiles extends StatelessWidget {
  final ProfileModel profile;
  final void Function(int) removeProfile;
  final void Function(List<ButtonViewScreenModel> buttons) clickProfile;
  const _ProfilesTiles(
      {Key? key,
      required this.profile,
      required this.clickProfile,
      required this.removeProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(profile.name),
      leading: const Icon(Icons.person),
      onTap: () {
        clickProfile(profile.buttons);
        Navigator.pop(context);
      },
      trailing: IconButton(
          onPressed: () {
            this.removeProfile(profile.id);
          },
          icon: const Icon(
            Icons.remove_circle,
            color: Colors.red,
          )),
    );
  }
}
