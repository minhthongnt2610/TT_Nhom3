import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/models/firebase/fb_nguoi_dung_model.dart';
import 'package:timetrack/screens/admin_screens/import_file_csv_screen/import_file_csv_screen.dart';
import 'package:timetrack/screens/common_screens/login_screen/login_screen.dart';
import 'package:timetrack/screens/employee_screens/employee_checkin_out_screen/employee_check_in_screen.dart';
import 'package:timetrack/screens/hr_screen/hr_check_in_screen/hr_check_in_screen.dart';
import 'package:timetrack/screens/manager_screens/manager_check_in_screen/manager_check_in_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final auth = AuthService();
  final store = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time Track",
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (!snap.hasData) {
            return LoginScreen();
          }
          final uid = snap.data!.uid;

          return FutureBuilder<FbNguoiDungModel?>(
            future: store.getUser(uid),
            builder: (context, userSnap) {
              if (userSnap.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (!userSnap.hasData) {
                return const Scaffold(
                  body: Center(
                    child: Text("Không tìm thấy thông tin người dùng"),
                  ),
                );
              }
              final user = userSnap.data!;
              if (user.vaiTro == 'admin') {
                return const ImportFileCsvScreen();
              } else if (user.vaiTro == 'nhanvien') {
                return const EmployeeCheckInScreen();
              } else if (user.vaiTro == 'hr') {
                return const HrCheckInScreen();
              }
              return const ManagerCheckInScreen();
            },
          );
        },
      ),
    );
  }
}
