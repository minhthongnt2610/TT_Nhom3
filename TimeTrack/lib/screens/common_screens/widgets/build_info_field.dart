import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../contains/app_colors.dart';

class BuildInfoField extends StatelessWidget {
  const BuildInfoField({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14 * height / 956,
                  color: AppColors.hexD79E4E,
                  fontFamily: 'balooPaaji',
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
