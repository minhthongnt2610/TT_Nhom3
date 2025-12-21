import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/screens/admin_screens/import_file_csv_screen/import_file_csv_screen.dart';
import 'package:timetrack/screens/common_screens/widgets/app_bar_widget.dart';

import '../../../common_widget/button_admin.dart';
import '../../../data/remote/firebase/firestore_service.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final firestoreService = FirestoreService();
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return FutureBuilder(
      future: firestoreService.getUser(auth.currentUser!.uid),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snap.data!;
        return Scaffold(
          appBar: AppBarWidget(isCheck: true, name: user.hoTen),
          body: Column(
            children: [
              SizedBox(height: 50 * height / 956),
              Center(
                child: ButtonAdmin(onPressed: () {}, title: "Cấu hình khu vực"),
              ),
              Center(
                child: ButtonAdmin(
                  onPressed: () {},
                  title: "Cấu hình thời gian",
                ),
              ),
              Center(
                child: ButtonAdmin(onPressed: () {}, title: "Tạo tài khoản"),
              ),
              Center(
                child: ButtonAdmin(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ImportFileCsvScreen()),
                    );
                  },
                  title: "Import file CSV",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
