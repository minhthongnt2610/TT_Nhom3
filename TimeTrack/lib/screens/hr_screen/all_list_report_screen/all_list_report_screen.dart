import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/models/firebase/fb_don_tu_model.dart';
import 'package:timetrack/screens/manager_screens/document_detail_screen/job_application_detail_screen.dart';

import '../../../contains/app_colors.dart';
import '../../manager_screens/document_detail_screen/explanation_detail_screen.dart';
import '../../manager_screens/document_detail_screen/leave_application_detail_screen.dart';

class AllListReportScreen extends StatelessWidget {
  AllListReportScreen({super.key});

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
    int height = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "ĐƠN TỪ CỦA TOÀN CÔNG TY",
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
        stream: _store.getAllDonTu(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Không có đơn nào",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExplanationDetailScreen(
                          idDon: item.id,
                          name: item.hoTen,
                          id: item.maNV,
                          department: item.phongBanID == 'it'
                              ? "IT"
                              : item.phongBanID == "kinh-doanh"
                              ? "Kinh doanh"
                              : "Kế toán",
                          fromDate: item.tuNgay,
                          toDate: item.denNgay,
                          reason: item.lyDo,
                        ),
                      ),
                    );
                  } else if (item.loaiDon == "Đơn xin công tác") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobApplicationDetailScreen(
                          idDon: item.id,

                          name: item.hoTen,
                          id: item.maNV,
                          department: item.phongBanID == 'it'
                              ? "IT"
                              : item.phongBanID == "kinh-doanh"
                              ? "Kinh doanh"
                              : "Kế toán",

                          fromDate: item.tuNgay,
                          toDate: item.denNgay,
                          reason: item.lyDo,
                          userId: '',
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LeaveApplicationDetailScreen(
                          idDon: item.id,

                          name: item.hoTen,
                          id: item.maNV,
                          department: item.phongBanID == 'it'
                              ? "IT"
                              : item.phongBanID == "kinh-doanh"
                              ? "Kinh doanh"
                              : "Kế toán",

                          fromDate: item.tuNgay,
                          toDate: item.denNgay,
                          reason: item.lyDo,
                        ),
                      ),
                    );
                  }
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
                        SizedBox(height: 4 * height / 956),
                        Text(
                          "Mã: ${item.maNV}",
                          style: TextStyle(
                            color: AppColors.backgroundAppBar,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'balooPaaji',
                          ),
                        ),
                        SizedBox(height: 4 * height / 956),
                        Text(
                          "Phòng ban: ${item.phongBanID == 'it'
                              ? "IT"
                              : item.phongBanID == "kinh-doanh"
                              ? "Kinh doanh"
                              : "Kế toán"}",
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
