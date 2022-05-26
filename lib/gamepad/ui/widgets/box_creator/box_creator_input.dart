import 'package:flutter/material.dart';

class BoxCreatorInputListTipeButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const BoxCreatorInputListTipeButton(
      {Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: onTap,
      leading: const Icon(Icons.remove),
    );
  }
}
