import 'package:flutter/material.dart';

import '../../../contains/app_colors.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TẠO BÁO CÁO",
          style: TextStyle(
            color: AppColors.backgroundAppBar,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'balooPaaji',
          ),
        ),
      ),
    );
  }
}
