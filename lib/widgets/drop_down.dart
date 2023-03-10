import 'package:flutter/material.dart';
import 'package:fluuter_chatgpt/constants/constant.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String currentModel = "Model1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: cardCol,
      items: getModelsItem,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
      value: currentModel,
    );
  }
}
