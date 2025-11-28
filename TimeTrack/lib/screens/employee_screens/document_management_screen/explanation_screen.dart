  import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_widget.dart';
  import 'package:timetrack/screens/employee_screens/document_management_screen/widgets/date_time_picker.dart';
  import 'package:timetrack/screens/employee_screens/document_management_screen/widgets/text_form_field_widget.dart';
  import '../../../contains/app_colors.dart';

  class ExplanationScreen extends StatefulWidget {
    const ExplanationScreen({super.key});
    @override
    State<ExplanationScreen> createState() => _ExplanationScreenState();
  }

  class _ExplanationScreenState extends State<ExplanationScreen> {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController codeController = TextEditingController();
    final TextEditingController departmentController = TextEditingController();
    final TextEditingController fromDate = TextEditingController();
    final TextEditingController toDate = TextEditingController();
    @override
    void dispose() {
      nameController.dispose();
      codeController.dispose();
      departmentController.dispose();
      fromDate.dispose();
      toDate.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      int height = MediaQuery.of(context).size.height.toInt();
      int width = MediaQuery.of(context).size.width.toInt();
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation: 0,
        ),
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

                          SizedBox(height: 29 * height / 956),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 33 * height / 956,
                                  child: DateTimePicker(
                                    controller: fromDate,
                                    title: "Từ ngày",
                                  ),
                                ),
                              ),
                              SizedBox(width: 10 * width / 440),
                              Expanded(
                                child: SizedBox(
                                  height: 33 * height / 956,
                                  child: DateTimePicker(
                                    controller: toDate,
                                    title: "Đến ngày",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 29 * height / 956),
                             SizedBox(
                               width: 130 * width / 440,
                              height: 33 * height / 956,
                              child: TextFormFieldWidget(
                                hintText: "Số ngày",
                                onChanged: (value) {},
                                maxLines: 1,
                                initialValue: null,
                                controller: departmentController,
                              ),
                            ),
                          SizedBox(height: 29 * height / 956),
                         TextFormFieldWidget(
                              hintText: "Ghi chú",
                              onChanged: (value) {},
                              maxLines: 6,
                              initialValue: null,
                              controller: departmentController,
                          ),
                          SizedBox(height: 20 * height / 956),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonWidget(onPressed: (){}, title: 'Chuyển',),
                              SizedBox(width: 10 * width / 440),
                              ButtonWidget(onPressed: (){}, title: 'Hủy',),
                            ],
                          )
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
