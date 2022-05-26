import 'package:flutter/material.dart';

class FloatingScreenButtonButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final Color color;
  const FloatingScreenButtonButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton.small(
        onPressed: onPressed,
        tooltip: '~~',
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
