import 'package:flutter/material.dart';
import 'package:game_pad_client/gamepad/repository/types_buttons.dart';
import 'package:game_pad_client/ui/widgets/dialog.dart';

class GenerateCodesButton {
  Future<List> generate(List<String> messages, BuildContext primaryContext,
      {bool isMouse = false}) async {
    // ListIterable
    final listaName = messages.map((e) async {
      final ctrl = TextEditingController(text: "");
      await getButtonCode(primaryContext, ctrl, e, isMouse);
      return ctrl.text;
    });

    List<String> response = [];
    for (var element in listaName) {
      try {
        final data = await element;
        response.add(data);
      } catch (err) {
        throw err;
      }
    }
    return response;
  }

  getButtonCode(BuildContext primaryContext, TextEditingController controller,
      String message, bool isMouse) async {
    final repository = GetButtonsTypeRepository();
    final itemsRepo = isMouse ? repository.dataMouse : repository.dataKeyboard;

    final listViewItems = ListView.builder(
        itemBuilder: (contextBuilder, index) {
          final itemRepo = itemsRepo[index];

          final item = ListTile(
            title: Text(itemRepo.getName()),
            onTap: () {
              Navigator.pop(contextBuilder);
              setControllerValue(itemRepo.getCode(), controller);
            },
          );

          if (index == 0 && isMouse == false) {
            return CustomAdd(controllerCustom: controller, item: item);
          }

          return item;
        },
        itemCount: itemsRepo.length);

    final title = Text("¿Cual es el boton que agregaras? $message");

    await CreateDialog(primaryContext).openSimple(title, listViewItems);

    if (controller.text == "") {
      throw "button is not valid";
    }
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
