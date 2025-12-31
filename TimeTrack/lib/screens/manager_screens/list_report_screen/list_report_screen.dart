import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/models/firebase/fb_don_tu_model.dart';

import '../../../contains/app_colors.dart';

class ListReportScreen extends StatelessWidget {
  ListReportScreen({super.key, required this.idQuanLy});

  final String idQuanLy;

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
        return 'Chưa duyệt';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "ĐƠN TỪ CỦA PHÒNG BAN",
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
        stream: _store.donChoDuyet(idQuanLy: idQuanLy),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Không có đơn nào đang chờ duyệt",
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
              return GestureDetector(
                onTap: () {
                  debugPrint("tap tap tap");
                  if (item.loaiDon == "Đơn xin nghỉ phép") {
                  } else if (item.loaiDon == "Đơn xin công tác") {
                  } else {}
                },
                child: Card(
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
                          "Họ tên: ${item.hoTen}",
                          style: TextStyle(
                            color: AppColors.backgroundAppBar,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'balooPaaji',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Mã: ${item.maNV}",
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
