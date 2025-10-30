import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/screens/employee_screens/dialogs/check_in_success_dialog.dart';

import '../common_screens/widgets/build_info_field.dart';

class InfoEmployee extends StatelessWidget {
  const InfoEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    String name = 'Phạm Lê Huyền Trân';
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              SizedBox(height: 10 * height / 956),
               GestureDetector(
                 onTap: () {
                   debugPrint("Chọn ảnh");
                 },
                 child: CircleAvatar(
                  radius: 60 * height / 956,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(radius: 57 * height / 956, backgroundColor: Colors.white),
                               ),
               ),

              SizedBox(height: 12 * height / 956),

              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28 * height / 956,
                  color: AppColors.hexD79E4E,
                  fontFamily: 'balooPaaji',
                )
              ),

              SizedBox(height: 25 * height / 956),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDDDC6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    BuildInfoField(title: 'Mã nhân viên'),
                    BuildInfoField(title: 'CCCD'),
                    BuildInfoField(title: 'Phòng ban'),
                    BuildInfoField(title: 'Chức vụ'),
                    BuildInfoField(title: 'Email'),
                    GestureDetector(
                      onTap: () {
                        debugPrint("Đổi mật khẩu");
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(right: 8.0 * width / 440),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Đổi mật khẩu",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13 * height / 956,
                              color: AppColors.hexD79E4E,
                              fontFamily: 'balooPaaji',
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

               SizedBox(height: 25 * height / 956),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hexF8790A,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  debugPrint('Đăng xuất');
                  checkInSuccessDialog(context);
                },
                child: Text(
                  'Đăng xuất',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
