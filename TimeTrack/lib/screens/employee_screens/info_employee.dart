import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common_screens/widgets/build_info_field.dart';

class InfoEmployee extends StatelessWidget {
  const InfoEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      backgroundColor: Colors.white,
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

              Text(
                'Nguyễn Minh Thông',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDDDC6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    BuildInfoField( title: 'Mã nhân viên',),
                    BuildInfoField( title: 'CCCD',),
                    BuildInfoField( title: 'Phòng ban',),
                    BuildInfoField( title: 'Chức vụ',),
                    BuildInfoField( title: 'Email',),
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

}
