import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CreateDialog {
  final BuildContext context;
  CreateDialog(this.context);

  openSimple(Widget title, Widget content) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title,
            content: content,
          );
        });
  }
}
