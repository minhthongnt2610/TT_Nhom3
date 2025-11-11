import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/screens/common_screens/forgot_password_screen.dart';
import 'package:timetrack/screens/common_screens/widgets/field_widget.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/check_in_screen.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 176 * height / 956),
                Image(
                  image: AssetImage("assets/images/logo_login_screen.png"),
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
                        suffixIcon: Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
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
                      SizedBox(height: 10 * height / 956),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            print("Quên mật khẩu");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                          },
                          child: Text(
                            "Quên mật khẩu",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 52 * height / 956),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                        ),
                        onPressed: () {
                          print("Đăng nhập");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckInScreen()));
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white),
                        ),
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
