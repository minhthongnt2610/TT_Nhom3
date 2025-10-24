import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/screens/common_screens/widgets/field_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              SizedBox(height: 176 * height / 956),
              Image(
                image: AssetImage("assets/logo/logo.png"),
                height: 200 * height / 956,
              ),
              SizedBox(height: 103 * height / 956),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36 * width / 440),
                child: Column(
                  children: [
                    FieldWidget(
                      labelText: "Email",
                      hintText: "",
                      suffixIcon: Icon(Icons.email_rounded),
                      onChange: (value) {},
                      validator: (value) {},
                      controller: emailController,
                    ),
                    SizedBox(height: 20 * height / 956),
                    FieldWidget(
                      labelText: "Password",
                      hintText: "",
                      isPassword: true,
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onChange: (value) {},
                      validator: (value) {},
                      controller: passwordController,
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
