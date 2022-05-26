import 'package:flutter/material.dart';
import 'package:game_pad_client/bloc/storage_bloc.dart';
import 'package:game_pad_client/gamepad/bloc/GamePadAddButtonPosition.dart';
import 'package:game_pad_client/gamepad/bloc/ProfilesBloc.dart';
import 'package:game_pad_client/gamepad/ui/widgets/settings/profiles.dart';
import 'package:game_pad_client/ui/widgets/dialog.dart';
import 'package:game_pad_client/ui/widgets/modal.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart' as provider;

class ViewListSimpleSettings extends StatelessWidget {
  final GamePadAddButtonPositionBloc gpab;
  final StorageBloc storageBloc;
  const ViewListSimpleSettings(
      {Key? key, required this.gpab, required this.storageBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _ViewListSimpleItem(
          icon: Icons.person,
          title: "Perfiles",
          onPressed: () {
            Navigator.pop(context);

            final widget =
                ProfileSettingsGamePad(gpab: gpab, storageBloc: storageBloc);

            CreateModal(context).bottomSheet(
                ("Perfiles"),
                provider.BlocProvider(
                  bloc: ProfilesBloc(),
                  child: widget,
                ));
          },
        ),
        _ViewListSimpleItem(
          icon: Icons.wifi,
          title: "Latencia",
          onPressed: () {},
        ),
        _ViewListSimpleItem(
          icon: Icons.clear,
          title: "Reset",
          onPressed: () {
            gpab.setAll([]);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _ViewListSimpleItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onPressed;
  const _ViewListSimpleItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title),
      trailing: Icon(icon),
    );
  }
}
