import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../contains/app_colors.dart';
import '../../../data/remote/firebase/auth_service.dart';
import '../../../data/remote/firebase/firestore_service.dart';
import '../../common_screens/document_screen/widgets/text_form_field_widget.dart';

class DetailEmployeeScreen extends StatefulWidget {
  const DetailEmployeeScreen({super.key});

  @override
  State<DetailEmployeeScreen> createState() => _DetailEmployeeScreenState();
}

class _DetailEmployeeScreenState extends State<DetailEmployeeScreen> {
  final firestoreService = FirestoreService();
  final authService = AuthService();
  late Future<dynamic> _userFuture;
  bool _isInit = false;
  final nameController = TextEditingController();
  final maController = TextEditingController();
  final phongBanController = TextEditingController();
  final vaiTroController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = authService.currentUser;
    if (currentUser != null) {
      _userFuture = firestoreService.getUser(currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Thông tin nhân viên",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.backgroundAppBar,
            fontFamily: 'balooPaaji',
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }

            final user = snapshot.data;
            if (user == null) {
              return const Center(child: Text("Không tìm thấy dữ liệu"));
            }
            if (!_isInit) {
              nameController.text = user.hoTen;
              maController.text = user.ma;
              phongBanController.text = user.phongBan;
              vaiTroController.text = user.vaiTro == 'nhanvien'
                  ? 'Nhân viên'
                  : user.vaiTro == 'quanly'
                  ? 'Quản lý'
                  : 'HR';
              emailController.text = user.email;
              _isInit = true;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100 * height / 956),

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
                        TextFormFieldWidget(
                          hintText: 'Họ tên',
                          controller: nameController,
                          maxLines: 1,
                          onChanged: (_) {},
                          initialValue: null,
                        ),
                        SizedBox(height: 8 * height / 956),
                        TextFormFieldWidget(
                          hintText: 'Mã',
                          controller: maController,
                          maxLines: 1,
                          onChanged: (_) {},
                          initialValue: null,
                        ),
                        SizedBox(height: 8 * height / 956),
                        TextFormFieldWidget(
                          hintText: 'Vai trò',
                          controller: vaiTroController,
                          maxLines: 1,
                          onChanged: (_) {},
                          initialValue: null,
                        ),
                        SizedBox(height: 8 * height / 956),
                        TextFormFieldWidget(
                          hintText: 'Phòng ban',
                          controller: phongBanController,
                          maxLines: 1,
                          onChanged: (_) {},
                          initialValue: null,
                        ),
                        SizedBox(height: 8 * height / 956),
                        TextFormFieldWidget(
                          hintText: 'email',
                          controller: emailController,
                          maxLines: 1,
                          onChanged: (_) {},
                          initialValue: null,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25 * height / 956),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                          showOnTapDialog(
                            context,
                            title: "Sửa",
                            content: "Bạn có chắc chắn muốn sửa nhân viên này?",
                            onTap: () async {},
                          );
                        },
                        child: Text(
                          'Sửa',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                            horizontal: 40,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          showOnTapDialog(
                            context,
                            title: "Xóa",
                            content: "Bạn có chắc chắn muốn xóa nhân viên này?",
                            onTap: () async {},
                          );
                        },
                        child: Text(
                          'xóa',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showOnTapDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onTap,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.hexD79E4E,
              fontFamily: 'balooPaaji',
            ),
          ),
          content: Text(
            content,
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
                onTap();
              },
              child: Text(
                title,
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
