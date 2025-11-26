import 'package:flutter/material.dart';
import 'package:timetrack/screens/common_screens/widgets/field_widget.dart';
import 'package:timetrack/screens/employee_screens/document_management_screen/widgets/text_form_field_widget.dart';

import '../../../contains/app_colors.dart';

class ExplanationScreen extends StatelessWidget {
   ExplanationScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();



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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 97 * height / 956),
                Text(
                  "ĐƠN XIN NGHỈ PHÉP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                    fontSize: 30 * height / 956,
                  ),
                ),
                SizedBox(height: 25 * height / 956),
                Container(
                  width: 361 * width / 440,
                  height: 576 * height / 956,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundAppBar,
                    borderRadius: BorderRadius.circular(36 * height / 956),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        SizedBox(height: 47 * height / 956),
                        SizedBox(
                          width: 330 * width / 440,
                          height: 33 * height / 956,
                          child: TextFormFieldWidget(
                            hintText: "Tên nhân viên",
                            onChanged: (value) {},
                            maxLines: 1,
                            initialValue: null,
                            controller: nameController,
                          ),
                        ),
                        SizedBox(height: 29 * height / 956),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 33 * height / 956,
                                child: TextFormFieldWidget(
                                  hintText: "Mã nhân viên",
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  initialValue: null,
                                  controller: codeController,
                                ),
                              ),
                            ),
                            SizedBox(width: 10 * width / 440),
                            Expanded(
                              child: SizedBox(
                                height: 33 * height / 956,
                                child: TextFormFieldWidget(
                                  hintText: "Phòng ban",
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  initialValue: null,
                                  controller: departmentController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
