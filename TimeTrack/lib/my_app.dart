import 'package:flutter/material.dart';
import 'package:timetrack/screens/common_screens/login_screen.dart';
import 'package:timetrack/screens/employee_screens/check_in_screen.dart';
import 'package:timetrack/screens/employee_screens/info_employee.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Time Track",
        home: LoginScreen(),
    );
  }
}
