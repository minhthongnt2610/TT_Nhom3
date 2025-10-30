import 'package:flutter/material.dart';

import '../../../contains/app_colors.dart';

void checkInSuccessDialog(BuildContext context) {
  int height = MediaQuery.of(context).size.height.toInt();
  int width = MediaQuery.of(context).size.width.toInt();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 300 * width / 440,
          padding: EdgeInsets.all(20 * height / 956),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * height / 956),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.backgroundColor, AppColors.backgroundButton],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.green.shade700,
                size: 60,
              ),
              SizedBox(height: 15 * height / 956),
              const Text(
                'Check in thành công!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                  fontFamily: 'balooPaaji',
                ),
              ),
              SizedBox(height: 15 * height / 956),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.exit_to_app_rounded, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    },
  );
}
