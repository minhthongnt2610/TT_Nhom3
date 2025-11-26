import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    super.key,
    required this.onTap,
    required this.controller,
    required this.title,
  });
  final VoidCallback onTap;
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          controller.text.isEmpty ? title : controller.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight:
            controller.text.isEmpty ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
