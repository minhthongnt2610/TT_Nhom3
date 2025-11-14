import 'package:flutter/material.dart';
import 'package:timetrack/screens/common_screens/forgot_password_screen.dart';
import 'package:timetrack/screens/common_screens/login_screen.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/check_in_screen.dart';
import 'package:timetrack/screens/employee_screens/document_management_screen/explanation_screen.dart';
import 'package:timetrack/screens/employee_screens/info_screen/info_employee.dart';
import 'package:timetrack/screens/common_screens/widgets/open_street_map.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Time Track",
        home: ExplanationScreen(),
    );
  }
}
