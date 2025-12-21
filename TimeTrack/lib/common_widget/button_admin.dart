import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';

class ButtonAdmin extends StatelessWidget {
  const ButtonAdmin({super.key, required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.backgroundAppBar,
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(250 * width / 440, 33 * height / 956),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'balooPaaji',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
