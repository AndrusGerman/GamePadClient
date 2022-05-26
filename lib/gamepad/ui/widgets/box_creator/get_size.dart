import 'package:flutter/material.dart';

class BoxCreatorGetSize extends StatelessWidget {
  final Function(String) controllerSizeSetValue;
  final TextEditingController controllerSize;
  const BoxCreatorGetSize(
      {Key? key,
      required this.controllerSize,
      required this.controllerSizeSetValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Column(
      children: [
        TextField(
          onChanged: (value) {
            // Ignore change
            if (value == "") {
              return;
            }
            // Set Max and min value
            final valueInt = int.parse(value).toInt();
            if (valueInt < 0 || valueInt > 390) {
              controllerSizeSetValue("390");
            }
          },
          keyboardType: TextInputType.number,
          controller: controllerSize,
        ),
        ElevatedButton(
            onPressed: () {
              if (controllerSize.text != "") {
                Navigator.pop(context);
              }
            },
            child: Container(
              child: Text("Guardar"),
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              controllerSize.clear();
            },
            child: Container(
              child: Text("Cancelar"),
            ))
      ],
    );

    return value;
  }
}
