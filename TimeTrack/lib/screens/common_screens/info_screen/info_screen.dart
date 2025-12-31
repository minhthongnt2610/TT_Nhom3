import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/screens/common_screens/change_password_screen/change_password_screen.dart';
import 'package:timetrack/screens/common_screens/login_screen/login_screen.dart';

import '../../../data/remote/firebase/auth_service.dart';
import '../../common_screens/widgets/build_info_field.dart';

class InfoEmployee extends StatelessWidget {
  InfoEmployee({super.key});

  final firestoreService = FirestoreService();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    final user = authService.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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

              FutureBuilder(
                future: firestoreService.getUser(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Lỗi: ${snapshot.error}');
                  }

                  final user = snapshot.data;
                  if (user == null) {
                    return const Text("Không tìm thấy dữ liệu người dùng");
                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint("Chọn ảnh");
                        },
                        child: CircleAvatar(
                          radius: 60 * height / 956,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 57 * height / 956,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12 * height / 956),
                      Text(
                        user.hoTen,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28 * height / 956,
                          color: AppColors.hexD79E4E,
                          fontFamily: 'balooPaaji',
                        ),
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
                            BuildInfoField(title: user.ma),
                            BuildInfoField(
                              title: user.vaiTro == 'nhanvien'
                                  ? 'Nhân viên'
                                  : user.vaiTro == 'quanly'
                                  ? 'Quản lý'
                                  : 'HR',
                            ),
                            BuildInfoField(title: user.phongBan),
                            BuildInfoField(title: user.email),
                            GestureDetector(
                              onTap: () {
                                debugPrint("Đổi mật khẩu");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChangePasswordScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 8.0 * width / 440,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Đổi mật khẩu",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13 * height / 956,
                                      color: AppColors.hexD79E4E,
                                      fontFamily: 'balooPaaji',
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                          showDialogSignOut(context);
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogSignOut(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Đăng xuất',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.hexD79E4E,
              fontFamily: 'balooPaaji',
            ),
          ),
          content: Text(
            "Bạn có muốn đăng xuất không?",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.hexD79E4E,
              fontFamily: 'balooPaaji',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Hủy',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.hexD79E4E,
                  fontFamily: 'balooPaaji',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hexF8790A,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await authService.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white70,
                  fontFamily: 'balooPaaji',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
