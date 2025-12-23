import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/extensions/date_time_extension.dart';

import '../../../models/firebase/fb_cham_cong_model.dart';

class LichSuChamCongScreen extends StatelessWidget {
  LichSuChamCongScreen({super.key, required this.uid});

  final chamCongService = FirestoreService();
  final String uid;
  final store = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LỊCH SỬ CHẤM CÔNG",
          style: TextStyle(
            color: AppColors.backgroundAppBar,
            fontFamily: 'balooPaaji',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: StreamBuilder(
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
                return Center(child: const CircularProgressIndicator());
              }

              return ColoredBox(
                color: AppColors.backgroundColor,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      color: AppColors.backgroundAppBar,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.access_time),
                        title: Text(
                          "Ngày: ${item.ngay}",
                          style: TextStyle(fontFamily: 'balooPaaji'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check-in: ${item.checkInTime.hhmm}p",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                            Text(
                              item.checkOutTime == null
                                  ? "Check-out: Chưa checkout"
                                  : "Check-out: ${item.checkOutTime?.hhmm}p",
                              style: TextStyle(fontFamily: 'balooPaaji'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
