import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final Widget prefixIcon;
  final String hintText;
  final bool obscureText;
  final bool enableSuggestion;
  final bool autoCorrect;

  final TextEditingController textEditingController;
  const InputWidget(
      {Key? key,
      required this.prefixIcon,
      required this.hintText,
      this.obscureText = false,
      this.enableSuggestion = false,
      this.autoCorrect = false,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        enableSuggestions: enableSuggestion,
        autocorrect: autoCorrect,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hoverColor: Colors.grey,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: IconButton(onPressed: () {}, icon: prefixIcon)),
      ),
    );
  }
}
