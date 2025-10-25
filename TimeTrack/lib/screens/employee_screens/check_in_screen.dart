import 'package:flutter/material.dart';
import 'package:timetrack/screens/employee_screens/widgets/app_bar_widget.dart';

import '../../contains/app_colors.dart';
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.hexF9C752, AppColors.hexFF1275],
          ),
        ),
      )
    );
  }
}
