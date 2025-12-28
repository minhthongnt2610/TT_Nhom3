import 'package:flutter/material.dart';
import 'package:timetrack/screens/hr_screen/detail_employee_screen/detail_employee_screen.dart';

import '../../../contains/app_colors.dart';
import '../../common_screens/history_check_in_out_screen/history_check_in_out_screen.dart';

class BottomSheetEmployee extends StatelessWidget {
  const BottomSheetEmployee({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.25,
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
                  'Chọn thông tin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                  ),
                ),

                SizedBox(height: 20 * height / 956),

                ElevatedButton(
                  onPressed: () {
                    debugPrint('Lịch sử chấm công');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LichSuChamCongScreen(uid: uid),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Lịch sử chấm công',
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
                    debugPrint('Thông tin nhân viên');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailEmployeeScreen(employeeID: uid),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Thông tin nhân viên',
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
