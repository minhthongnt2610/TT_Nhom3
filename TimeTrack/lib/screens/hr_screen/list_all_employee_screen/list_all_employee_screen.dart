import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';

import '../../../models/firebase/fb_nguoi_dung_model.dart';

class ListAllEmployeeScreen extends StatelessWidget {
  ListAllEmployeeScreen({super.key, required this.uid});

  final _store = FirestoreService();
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _store.getUser(uid),
      builder: (context, userSnap) {
        if (!userSnap.hasData) {
          return Center(child: const CircularProgressIndicator());
        }
        final user = userSnap.data;
        if (user?.vaiTro != 'hr') {
          return const Center(child: Text("Bạn không có quyền truy cập"));
        }
        return StreamBuilder<List<FbNguoiDungModel>>(
          stream: _store.getAll(user!.id),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(child: const CircularProgressIndicator());
            }
            final list = snap.data ?? [];
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "TOÀN BỘ NHÂN VIÊN",
                  style: TextStyle(
                    color: AppColors.backgroundAppBar,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                  ),
                ),
                backgroundColor: AppColors.backgroundColor,
              ),
              body: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final nv = list[index];
                  return GestureDetector(
                    onTap: () {
                      debugPrint("tap tap tap");
                    },
                    child: Card(
                      color: AppColors.backgroundAppBar,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          "Họ và tên: ${nv.hoTen}",
                          style: TextStyle(fontFamily: 'balooPaaji'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mã: ${nv.ma}",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                            Text(
                              "Phòng ban: ${nv.phongBan}",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                            Text(
                              nv.vaiTro == 'nhanvien'
                                  ? "Vai trò: Nhân viên"
                                  : "Vai trò: Quản lý",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                            Text(
                              "Email: ${nv.email}",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
