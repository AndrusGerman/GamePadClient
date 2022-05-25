import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/repository/types_buttons.dart';

class GenerateCodesButton {
  Future<List> generate(
      List<String> messages, BuildContext primaryContext) async {
    // ListIterable
    final listaName = messages.map((e) async {
      final ctrl = TextEditingController(text: "");
      await getButtonCode(primaryContext, ctrl, e);
      return ctrl.text;
    });

    List<String> response = [];
    for (var element in listaName) {
      final data = await element;
      response.add(data);
    }
    return response;
  }

  getButtonCode(BuildContext primaryContext, TextEditingController controller,
      String message) async {
    final repository = GetButtonsTypeRepository();

    final listViewItems = ListView.builder(
        itemBuilder: (contextBuilder, index) {
          final itemRepo = repository.data[index];

          final item = ListTile(
            title: Text(itemRepo.getName()),
            onTap: () {
              Navigator.pop(contextBuilder);
              setControllerValue(itemRepo.getCode(), controller);
            },
          );

          if (index == 0) {
            return CustomAdd(controllerCustom: controller, item: item);
          }

          return item;
        },
        itemCount: repository.data.length);

    await showDialog(
        context: primaryContext,
        builder: (context) {
          return AlertDialog(
            title: Text("¿Cual es el boton que agregaras? " + message),
            content: SizedBox(
              height: 270,
              width: double.infinity,
              child: listViewItems,
            ),
          );
        });
  }

  setControllerValue(String value, TextEditingController controller) {
    controller.value = controller.value.copyWith(
        text: value, selection: TextSelection.collapsed(offset: value.length));
  }
}

class CustomAdd extends StatelessWidget {
  final TextEditingController controllerCustom;
  final Widget item;
  const CustomAdd({
    Key? key,
    required this.controllerCustom,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {},
          keyboardType: TextInputType.text,
          controller: controllerCustom,
        ),
        ElevatedButton(
          onPressed: () {
            final val = controllerCustom.text;
            if (val.length == 1) {
              val.toUpperCase();
            }
            if (val != "") {
              Navigator.pop(context);
            }
          },
          child: const Text("Guardar Personalizado"),
        ),
        item,
      ],
    );
  }
}
