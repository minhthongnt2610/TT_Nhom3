import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoEmployee extends StatelessWidget {
  const InfoEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Nút back
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Avatar tròn
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 57,
                  backgroundColor: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              // Tên nhân viên
              Text(
                'Nguyễn Minh Thông',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              // Khung thông tin
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDDDC6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    buildInfoField('Mã nhân viên'),
                    buildInfoField('CCCD'),
                    buildInfoField('Phòng Ban'),
                    buildInfoField('Chức vụ'),
                    buildInfoField('Email'),
                    buildInfoField('Mật khẩu (ẩn)', hasChangePassword: true),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Nút đăng xuất
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4A261),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  // Xử lý đăng xuất
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

  // Widget tạo từng dòng thông tin
  Widget buildInfoField(String label, {bool hasChangePassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
