import 'package:flutter/material.dart';
import 'package:timetrack/extensions/date_time_extension.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.hintText,
    required this.time,
    required this.onTap,
  });

  final String hintText;
  final TimeOfDay? time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'balooPaaji',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black26,
              fontSize: 15,
              fontFamily: 'balooPaaji',
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.white70,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2,
            ),
          ),
          controller: TextEditingController(
            text: time != null ? time!.toHHmm() : '',
          ),
          readOnly: true,
        ),
      ),
    );
  }
}
