import 'package:flutter/material.dart';
import 'package:timetrack/screens/common_screens/login_screen.dart';
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
