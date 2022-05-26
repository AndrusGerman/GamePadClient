import 'package:flutter/material.dart';

class SnackBarGamePad {
  final BuildContext context;
  SnackBarGamePad(this.context);

  warning(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Color.fromARGB(255, 48, 48, 48)),
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),

      backgroundColor: Colors.amber,
      // action: SnackBarAction(
      //   label: 'ACTION',
      //   onPressed: () {},
      // ),
    ));
  }

  success(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Color.fromARGB(255, 48, 48, 48)),
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),

      backgroundColor: Colors.green,
      // action: SnackBarAction(
      //   label: 'ACTION',
      //   onPressed: () {},
      // ),
    ));
  }

  danger(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Color.fromARGB(255, 48, 48, 48)),
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),

      backgroundColor: Colors.red,
      // action: SnackBarAction(
      //   label: 'ACTION',
      //   onPressed: () {},
      // ),
    ));
  }
}
