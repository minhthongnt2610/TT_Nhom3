import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/data/remote/firebase/excelService.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/models/firebase/fb_bao_cao_tong_hop_model.dart';
import 'package:timetrack/screens/common_screens/document_screen/widgets/date_time_picker.dart';
import 'package:timetrack/screens/hr_screen/widgets/bottom_sheet_service.dart';

import '../../../contains/app_colors.dart';

class HRCreateReportScreen extends StatefulWidget {
  const HRCreateReportScreen({super.key});

  @override
  State<HRCreateReportScreen> createState() => _HRCreateReportScreenState();
}

class _HRCreateReportScreenState extends State<HRCreateReportScreen> {
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final FirestoreService _store = FirestoreService();
  bool _loading = false;
  List<FbBaoCaoTongHopModel> _baoCao = [];
  final ExcelService excelService = ExcelService();

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Text(
          "HR TẠO BÁO CÁO",
          style: TextStyle(
            color: AppColors.backgroundAppBar,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'balooPaaji',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 50 * height / 956,
              child: DateTimePicker(controller: fromDate, title: "Từ ngày"),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50 * height / 956,
              child: DateTimePicker(controller: toDate, title: "Đến ngày"),
            ),
            const SizedBox(height: 16),
            ButtonAdmin(
              title: "Tạo báo cáo",
              onPressed: () async {
                if (fromDate.text.isEmpty || toDate.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Vui lòng chọn đủ Từ ngày và Đến ngày",
                        style: TextStyle(fontFamily: 'balooPaaji'),
                      ),
                    ),
                  );
                  return;
                }

                if (fromDate.text.compareTo(toDate.text) > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Từ ngày phải nhỏ hơn Đến ngày",
                        style: TextStyle(fontFamily: 'balooPaaji'),
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  _loading = true;
                  _baoCao.clear();
                });

                final data = await _store.hrBaoCaoPhongBan(
                  tuNgay: fromDate.text,
                  denNgay: toDate.text,
                );

                setState(() {
                  _baoCao = data;
                  _loading = false;
                });
              },
            ),

            const SizedBox(height: 16),
            if (_loading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            if (_baoCao.isNotEmpty)
              Container(
                color: AppColors.backgroundColor,
                width: 420 * width / 440,
                height: 470 * height / 956,
                child: ListView.builder(
                  itemCount: _baoCao.length,
                  itemBuilder: (_, index) {
                    final item = _baoCao[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.person_2_outlined),
                        title: Text(
                          item.hoTen,
                          style: TextStyle(fontFamily: 'balooPaaji'),
                        ),
                        subtitle: Text(
                          "Mã: ${item.maNV} | "
                          "Phòng ban: ${item.phongBan} | "
                          "Ngày làm: ${item.soNgayLam} | "
                          "Ngày nghỉ: ${item.soNgayNghi}",
                          style: TextStyle(fontFamily: 'balooPaaji'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ButtonAdmin(
              onPressed: () async {
                final file = await excelService.exportBaoCaoTongHop(_baoCao);
                debugPrint(file.path);
                if (!mounted) return;
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return BottomSheetService(path: file.path);
                  },
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Đã xuất file Excel:\n${file.path}",
                      style: TextStyle(fontFamily: 'balooPaaji'),
                    ),
                  ),
                );
              },
              title: "Xuất file",
            ),
          ],
        ),
      ),
    );
  }
}
