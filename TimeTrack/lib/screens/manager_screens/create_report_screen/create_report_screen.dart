import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/screens/common_screens/document_screen/widgets/date_time_picker.dart';

import '../../../contains/app_colors.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50 * height / 956,
                child: DateTimePicker(controller: fromDate, title: "Từ ngày"),
              ),
              SizedBox(height: 13 * height / 440),
              SizedBox(
                height: 50 * height / 956,
                child: DateTimePicker(controller: toDate, title: "Đến ngày"),
              ),
              SizedBox(height: 13 * height / 440),
              ButtonAdmin(onPressed: () {}, title: "Tạo báo cáo"),
            ],
          ),
        ),
      ),
    );
  }
}
