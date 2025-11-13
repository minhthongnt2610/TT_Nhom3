import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.maxLines,
    required this.initialValue,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white54, fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white30, fontSize: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white12,
      ),

      onChanged: onChanged,
      maxLines: maxLines,
      initialValue: initialValue,
    );
  }
}