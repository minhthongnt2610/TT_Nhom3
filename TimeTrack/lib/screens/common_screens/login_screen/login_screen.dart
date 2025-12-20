import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/screens/common_screens/widgets/field_widget.dart';
import 'package:timetrack/screens/hr_screen/hr_check_in_screen/hr_check_in_screen.dart';
import 'package:timetrack/screens/manager_screens/manager_check_in_screen/manager_check_in_screen.dart';

import '../../../data/remote/firebase/auth_service.dart';
import '../../admin_screens/import_file_csv_screen/import_file_csv_screen.dart';
import '../../employee_screens/employee_checkin_out_screen/employee_check_in_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static final String route = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authService = AuthService();
  late bool _isLoading = false;

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
                          onTap: () async {
                            print("Quên mật khẩu");
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
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                final role = await authService.logInAndGetRole(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                                if (!mounted) return;
                                setState(() {
                                  _isLoading = false;
                                });
                                if (role == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Email/mật khẩu không đúng hoặc tài khoản chưa có role",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (role == "admin") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ImportFileCsvScreen(),
                                    ),
                                  );
                                } else if (role == "nhanvien") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const EmployeeCheckInScreen(),
                                    ),
                                  );
                                } else if (role == "hr") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HrCheckInScreen(),
                                    ),
                                  );
                                } else if (role == "quanly") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ManagerCheckInScreen(),
                                    ),
                                  );
                                }
                              },
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
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
