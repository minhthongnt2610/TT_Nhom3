import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';

import '../models/firebase/fb_nguoi_dung_model.dart';

class Xemtoanbonhanvien extends StatelessWidget {
  Xemtoanbonhanvien({super.key, required this.uid});

  final _store = FirestoreService();
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _store.getUser(uid),
      builder: (context, userSnap) {
        if (!userSnap.hasData) {
          return const CircularProgressIndicator();
        }
        final user = userSnap.data;
        if (user?.vaiTro != 'hr') {
          return const Center(child: Text("Bạn không có quyền truy cập"));
        }
        return StreamBuilder<List<FbNguoiDungModel>>(
          stream: _store.getAll(user!.id),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const CircularProgressIndicator();
            }
            final list = snap.data ?? [];
            return Scaffold(
              appBar: AppBar(title: const Text("Toàn bộ nhân viên")),
              body: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final nv = list[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(nv.hoTen),
                    subtitle: Text(nv.email),
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
