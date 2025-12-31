import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/screens/admin_screens/config_time_screen/config_time_screen.dart';
import 'package:timetrack/screens/admin_screens/import_file_csv_screen/import_file_csv_screen.dart';
import 'package:timetrack/screens/admin_screens/regional_configuration_screen/regional_configuration_screen.dart';
import 'package:timetrack/screens/common_screens/widgets/app_bar_widget.dart';

import '../../../common_widget/button_admin.dart';
import '../../../data/remote/firebase/firestore_service.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  static final String route = '/homeAdmin';

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final firestoreService = FirestoreService();
    int height = MediaQuery.of(context).size.height.toInt();
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        firestoreService.getUser(auth.currentUser!.uid),
        firestoreService.getKvcc(),
      ]),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              'Lỗi: ${snap.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final user = snap.data![0];
        final kvcc = snap.data![1];
        return Scaffold(
          appBar: AppBarWidget(isCheck: true, name: user!.hoTen),
          body: Column(
            children: [
              SizedBox(height: 50 * height / 956),
              Center(
                child: ButtonAdmin(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegionalConfigurationScreen(
                          id: kvcc.id,
                          tenKv: kvcc.tenKhuVuc,
                          kvLat: kvcc.toaDo.latitude,
                          kvLon: kvcc.toaDo.longitude,
                          banKinh: kvcc.banKinh,
                        ),
                      ),
                    );
                  },
                  title: "Cấu hình khu vực",
                ),
              ),
              Center(
                child: ButtonAdmin(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConfigTimeScreen()),
                    );
                  },
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
