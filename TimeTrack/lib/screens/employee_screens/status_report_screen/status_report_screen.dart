import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/models/firebase/fb_don_tu_model.dart';

import '../../../contains/app_colors.dart';

class StatusReportScreen extends StatelessWidget {
  StatusReportScreen({super.key, required this.nvId});

  final String nvId;
  final FirestoreService _store = FirestoreService();

  Color _statusColor(String status) {
    switch (status) {
      case 'da_duyet':
        return Colors.green;
      case 'tu_choi':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'da_duyet':
        return 'Đã duyệt';
      case 'tu_choi':
        return 'Từ chối';
      default:
        return 'Chờ duyệt';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "ĐƠN TỪ CỦA TÔI",
          style: TextStyle(
            fontFamily: 'balooPaaji',

            color: AppColors.backgroundAppBar,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<FbDonTuModel>>(
        stream: _store.getDonCuaNV(nvId: nvId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Bạn chưa gửi đơn nào",
                style: TextStyle(
                  color: AppColors.backgroundAppBar,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'balooPaaji',
                ),
              ),
            );
          }

          final list = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    Icons.description,
                    color: _statusColor(item.trangThai),
                  ),
                  title: Text(
                    item.loaiDon,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'balooPaaji',
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Từ: ${item.tuNgay} → ${item.denNgay}",
                        style: TextStyle(
                          color: AppColors.backgroundAppBar,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'balooPaaji',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Lý do: ${item.lyDo}",
                        style: TextStyle(
                          color: AppColors.backgroundAppBar,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'balooPaaji',
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    _statusText(item.trangThai),
                    style: TextStyle(
                      color: _statusColor(item.trangThai),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'balooPaaji',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
