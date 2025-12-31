import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_widget.dart';
import 'package:timetrack/data/remote/firebase/function_service.dart';
import 'package:timetrack/screens/common_screens/document_screen/widgets/date_time_picker.dart';
import 'package:timetrack/screens/common_screens/document_screen/widgets/text_form_field_widget.dart';

import '../../../contains/app_colors.dart';

class JobApplicationScreen extends StatefulWidget {
  const JobApplicationScreen({
    super.key,
    required this.name,
    required this.id,
    required this.department,
    required this.userId,
  });

  final String userId;
  final String name;
  final String id;
  final String department;

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final function = FunctionService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    codeController.text = widget.id;
    departmentController.text = widget.department;
  }

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
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 97 * height / 956),
                Text(
                  "ĐƠN XIN CÔNG TÁC",
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
                        TextFormFieldWidget(
                          hintText: "Ghi chú",
                          onChanged: (value) {},
                          maxLines: 6,
                          initialValue: null,
                          controller: reasonController,
                        ),
                        SizedBox(height: 20 * height / 956),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              onPressed: () async {
                                final result = await function.taoDonTu(
                                  loaiDon: "Đơn xin công tác",
                                  lyDo: reasonController.text,
                                  tuNgay: fromDate.text,
                                  denNgay: toDate.text,
                                );
                                if (result['success'] == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Gửi đơn thành công"),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result['message'])),
                                  );
                                }
                              },
                              title: 'Chuyển',
                            ),
                            SizedBox(width: 10 * width / 440),
                            ButtonWidget(onPressed: () {}, title: 'Hủy'),
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
