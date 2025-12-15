import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';

import '../models/firebase/fb_cham_cong_model.dart';

class LichSuChamCongScreen extends StatelessWidget {
  LichSuChamCongScreen({super.key, required this.uid});

  final chamCongService = FirestoreService();
  final String uid;
  final store = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch sử chấm công")),
      body:
          /*StreamBuilder<List<FbChamCongModel>>(
        stream: chamCongService.getHistoryAttendance(uid),
        builder: (context, snapshot) {
          print("LOGIN UID: ${FirebaseAuth.instance.currentUser?.uid}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Không có quyền truy cập"));
          }

          final list = snapshot.data ?? [];

          if (list.isEmpty) {
            return const Center(child: Text("Chưa có dữ liệu chấm công"));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text("Ngày ${item.ngay}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Check-in: ${item.checkInTime}"),
                      Text(
                        "Check-out: ${item.checkOutTime ?? 'Chưa checkout'}",
                      ),
                      Text("Trạng thái: ${item.trangThai}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),*/
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, authSnapshot) {
              if (!authSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<List<FbChamCongModel>>(
                stream: store.getHistoryAttendance(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Lỗi: ${snapshot.error}");
                  }
                  final list = snapshot.data ?? [];
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text("Ngày ${item.ngay}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Check-in: ${item.checkInTime}"),
                              Text(
                                "Check-out: ${item.checkOutTime ?? 'Chưa checkout'}",
                              ),
                              Text("Trạng thái: ${item.trangThai}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
    );
  }
}
