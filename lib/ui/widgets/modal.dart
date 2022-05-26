import 'package:flutter/material.dart';

class CreateModal {
  final BuildContext context;
  CreateModal(this.context);

  bottomSheet(Widget title, Widget content) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return content;
        });
  }
}
