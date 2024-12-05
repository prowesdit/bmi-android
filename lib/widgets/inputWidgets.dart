import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? textController;
  final Icon? prefixIcon;
  final String? hintText;
  final String? label;

  //construnctor
  const InputField(
      {super.key,
      required this.textController,
      required this.prefixIcon,
      required this.hintText,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.7),
        filled: true,
        prefixIcon: prefixIcon,
        hintText: hintText,
        label: Text(label!),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              21,
            ),
          ),
        ),
      ),
    );
  }
}
