import 'package:flutter/material.dart';
import 'package:timetrack/screens/common_screens/widgets/field_widget.dart';

import '../../../contains/app_colors.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.hexFFF0F0, AppColors.hexD79E4E],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 97 * height / 956),
                Text(
                  "ĐƠN XIN NGHỈ PHÉP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                    fontSize: 30 * height / 956,
                  ),
                ),
                SizedBox(height: 25 * height / 956),
                Container(
                  width: 361 * width / 440,
                  height: 576 * height / 956,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundAppBar,
                    borderRadius: BorderRadius.circular(36 * height / 956),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 47 * height / 956),
                      FieldWidget(
                        labelText: "Họ và tên",
                        hintText: '',
                        suffixIcon: null,
                        onChange: (value) {},
                        validator: (value) {},
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
