import 'package:flutter/material.dart';

class ViewListSimpleSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _ViewListSimpleItem(
          icon: Icons.person,
          title: "Perfiles",
          onPressed: () {
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
