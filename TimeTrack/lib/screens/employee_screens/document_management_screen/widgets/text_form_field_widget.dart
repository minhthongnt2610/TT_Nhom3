import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.maxLines,
    required this.initialValue,
    required this.controller,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? initialValue;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 14,fontFamily: 'balooPaaji'),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 15,fontFamily: 'balooPaaji'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white70,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
      ),
      textAlign: TextAlign.start,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      initialValue: initialValue,
    );
  }
}
