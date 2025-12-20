import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';

import '../../../contains/app_colors.dart';
import '../../../models/firebase/fb_nguoi_dung_model.dart';

class ListEmployeeOfDepartmentScreen extends StatelessWidget {
  ListEmployeeOfDepartmentScreen({super.key, required this.uid});

  final _store = FirestoreService();
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FbNguoiDungModel?>(
      future: _store.getUser(uid),
      builder: (context, userSnap) {
        if (userSnap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!userSnap.hasData) {
          return const Scaffold(
            body: Center(child: Text("Không tìm thấy người dùng")),
          );
        }
        final user = userSnap.data!;
        if (user.vaiTro != 'quanly') {
          return const Scaffold(
            body: Center(child: Text("Bạn không có quyền truy cập")),
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "NHÂN VIÊN PHÒNG ${user.phongBan.toUpperCase()}",
              style: const TextStyle(
                color: AppColors.backgroundAppBar,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'balooPaaji',
              ),
            ),
          ),
          body: StreamBuilder<List<FbNguoiDungModel>>(
            stream: _store.getEmployeeDepartment(user.phongBanID),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(
                  child: Text(
                    "Lỗi: ${snap.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              final list = snap.data ?? [];
              if (list.isEmpty) {
                return const Center(child: Text("Không có nhân viên"));
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final nv = list[index];
                  return Card(
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
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
