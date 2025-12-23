import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/extensions/date_time_extension.dart';
import 'package:timetrack/screens/admin_screens/widgets/item_time.dart';

import '../../../contains/app_colors.dart';
import '../../../models/firebase/fb_thoi_gian_lam_viec_model.dart';
import '../../../models/thoi_gian_lam_viec_model.dart';
import '../../common_screens/document_screen/widgets/text_form_field_widget.dart';
import '../widgets/time_picker_field.dart';

class ConfigTimeScreen extends StatefulWidget {
  const ConfigTimeScreen({super.key});

  @override
  State<ConfigTimeScreen> createState() => ConfigTimeScreenState();
}

class ConfigTimeScreenState extends State<ConfigTimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tenCaController = TextEditingController();

  TimeOfDay? _gioBatDau;
  TimeOfDay? _gioKetThuc;
  String? _editingId;
  final _repository = FirestoreService();

  @override
  void dispose() {
    _tenCaController.dispose();
    super.dispose();
  }

  Future<void> _pickGioBatDau() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _gioBatDau ?? const TimeOfDay(hour: 7, minute: 0),
    );

    if (result != null) {
      setState(() {
        _gioBatDau = result;
      });
    }
  }

  Future<void> _pickGioKetThuc() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _gioKetThuc ?? const TimeOfDay(hour: 18, minute: 00),
    );
    if (result != null) {
      setState(() {
        _gioKetThuc = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "CẤU HÌNH CA LÀM VIỆC",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'balooPaaji',
            color: AppColors.backgroundAppBar,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: _tenCaController,
                hintText: 'Tên ca',
                onChanged: (value) {},
                maxLines: 1,
                initialValue: null,
              ),
              SizedBox(height: 16 * height / 956),
              TimePickerField(
                time: _gioBatDau,
                onTap: _pickGioBatDau,
                hintText: 'Giờ bắt đầu',
              ),
              SizedBox(height: 16 * height / 956),
              TimePickerField(
                time: _gioKetThuc,
                onTap: _pickGioKetThuc,
                hintText: 'Giờ kết thúc',
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonAdmin(
                      onPressed: () {
                        _repository.addThoiGianLamViec(
                          ThoiGianLamViecModel(
                            id: '',
                            tenCa: _tenCaController.text,
                            gioBatDau: _gioBatDau!,
                            gioKetThuc: _gioKetThuc!,
                          ),
                        );
                        _tenCaController.clear();
                        setState(() {
                          _gioBatDau = null;
                          _gioKetThuc = null;
                          FocusScope.of(context).unfocus();
                        });
                        _formKey.currentState!.reset();
                      },
                      title: 'Lưu',
                    ),
                  ),
                  Expanded(
                    child: ButtonAdmin(
                      onPressed: () {
                        _repository.updateThoiGianLamViec(
                          ThoiGianLamViecModel(
                            id: _editingId!,
                            tenCa: _tenCaController.text,
                            gioBatDau: _gioBatDau!,
                            gioKetThuc: _gioKetThuc!,
                          ),
                        );
                        _tenCaController.clear();
                        setState(() {
                          _gioBatDau = null;
                          _gioKetThuc = null;
                          FocusScope.of(context).unfocus();
                        });
                        _formKey.currentState!.reset();
                      },
                      title: 'Sửa',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * height / 956),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lịch sử ca làm việc',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'balooPaaji',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: StreamBuilder<List<FbThoiGianLamViecModel>>(
                          stream: _repository.getThoiGianLamViec(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError) {
                              debugPrint('Error:' + snapshot.error.toString());
                              return const Center(
                                child: Text(
                                  'Lỗi tải dữ liệu',
                                  style: TextStyle(fontFamily: 'balooPaaji'),
                                ),
                              );
                            }

                            final data = snapshot.data ?? [];

                            if (data.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Chưa có ca làm việc nào',
                                  style: TextStyle(
                                    fontFamily: 'balooPaaji',
                                    color: Colors.black45,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return ItemTime(
                                  model: item,
                                  onTap: () {
                                    setState(() {
                                      _editingId = item.id;
                                      _tenCaController.text = item.tenCa;
                                      _gioBatDau = item.gioBatDau.toTimeOfDay();
                                      _gioKetThuc = item.gioKetThuc
                                          .toTimeOfDay();
                                    });
                                  },
                                  onDelete: () async {
                                    final isConfirm = await showDialog<bool>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Xác nhận'),
                                          content: const Text(
                                            'Bạn có chắc chắn muốn xóa không?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                              child: const Text('Hủy'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.backgroundAppBar,
                                              ),
                                              child: const Text('Xóa'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (isConfirm == true) {
                                      await _repository.deleteThoiGianLamViec(
                                        item.id,
                                      );
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                      });
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
