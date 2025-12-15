import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';

import '../models/firebase/fb_nguoi_dung_model.dart';

// class Xemdsnhanviencuaphongban extends StatelessWidget {
//   Xemdsnhanviencuaphongban({super.key, required this.uid});
//
//   final _store = FirestoreService();
//   final String uid;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<FbNguoiDungModel?>(
//       future: _store.getUser(uid),
//       builder: (context, userSnap) {
//         if (!userSnap.hasData) {
//           return const CircularProgressIndicator();
//         }
//         final user = userSnap.data;
//         if (user?.vaiTro != 'quanly') {
//           return const Center(child: Text("Bạn không có quyền truy cập"));
//         }
//         return StreamBuilder<List<FbNguoiDungModel>>(
//           stream: _store.getEmployeeDepartment(user!.phongBanID),
//           builder: (context, snap) {
//             if (!snap.hasData) {
//               return const CircularProgressIndicator();
//             }
//             final list = snap.data ?? [];
//             return Scaffold(
//               appBar: AppBar(title: const Text("Nhân viên phòng ban")),
//               body: ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (context, index) {
//                   final nv = list[index];
//                   return ListTile(
//                     leading: const Icon(Icons.person),
//                     title: Text(nv.hoTen),
//                     subtitle: Text(nv.email),
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
class Xemdsnhanviencuaphongban extends StatelessWidget {
  Xemdsnhanviencuaphongban({super.key, required this.uid});

  final _store = FirestoreService();
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FbNguoiDungModel?>(
      future: _store.getUser(uid), // ✅ ĐÚNG
      builder: (context, userSnap) {
        // 1️⃣ Đang load Future
        if (userSnap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2️⃣ Không có dữ liệu user
        if (!userSnap.hasData) {
          return const Scaffold(
            body: Center(child: Text("Không tìm thấy người dùng")),
          );
        }

        final user = userSnap.data!;

        // 3️⃣ Không phải quản lý
        if (user.vaiTro != 'quanly') {
          return const Scaffold(
            body: Center(child: Text("Bạn không có quyền truy cập")),
          );
        }

        // 4️⃣ Stream danh sách nhân viên phòng ban
        return Scaffold(
          appBar: AppBar(title: const Text("Nhân viên phòng ban")),
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
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(nv.hoTen),
                    subtitle: Text(nv.email),
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
