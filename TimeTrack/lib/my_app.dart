import 'package:flutter/material.dart';
import 'package:timetrack/screens/employee_screens/check_in_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Time Track",
        home: CheckInScreen(),
    );
  }
}
