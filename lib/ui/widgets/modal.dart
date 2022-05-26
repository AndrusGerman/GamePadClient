import 'package:flutter/material.dart';

class CreateModal {
  final BuildContext context;
  CreateModal(this.context);

  bottomSheet(String title, Widget content) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: content,
              ),
            ],
          );
        });
  }
}
