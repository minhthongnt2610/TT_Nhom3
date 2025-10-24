import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          child: Column(
            children: [
              SizedBox(
                height: 176 * height / 928,
              ),
              Image(
                image: AssetImage("assets/logo/logo.png"),
                height: 200 * height / 928,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
