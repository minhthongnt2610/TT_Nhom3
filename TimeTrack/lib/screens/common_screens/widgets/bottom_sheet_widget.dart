import 'package:flutter/material.dart';

import '../../../contains/app_colors.dart';
import '../document_screen/explanation_screen.dart';
import '../document_screen/job_application_screen.dart';
import '../document_screen/leave_application_screen.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
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
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.25,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.backgroundAppBar,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 50 * width / 440,
                  height: 5 * height / 956,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5 * height / 956),
                  ),
                ),

                const Text(
                  'Chọn đơn',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                  ),
                ),

                SizedBox(height: 20 * height / 956),

                ElevatedButton(
                  onPressed: () {
                    debugPrint('Đơn xin nghỉ phép');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExplanationScreen(
                          name: name,
                          id: id,
                          department: department,
                          userId: userId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Đơn xin nghỉ phép',
                    style: TextStyle(
                      fontSize: 16 * height / 956,
                      fontFamily: 'balooPaaji',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10 * height / 956),

                ElevatedButton(
                  onPressed: () {
                    debugPrint('Đơn giải trình');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaveApplicationScreen(
                          name: name,
                          id: id,
                          department: department,
                          userId: userId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Đơn giải trình',
                    style: TextStyle(
                      fontSize: 16 * height / 956,
                      fontFamily: 'balooPaaji',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10 * height / 956),

                ElevatedButton(
                  onPressed: () {
                    debugPrint('Đơn đăng ký công tác');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobApplicationScreen(
                          userId: userId,
                          name: name,
                          id: id,
                          department: department,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Đơn đăng ký công tác',
                    style: TextStyle(
                      fontSize: 16 * height / 956,
                      fontFamily: 'balooPaaji',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
