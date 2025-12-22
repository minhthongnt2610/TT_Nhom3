import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/extensions/date_time_extension.dart';

import '../../../contains/app_colors.dart';
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

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_gioBatDau == null || _gioKetThuc == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn giờ bắt đầu và kết thúc')),
      );
      return;
    }

    final tenCa = _tenCaController.text.trim();
    final gioBatDauStr = _gioBatDau!.toHHmm();
    final gioKetThucStr = _gioKetThuc!.toHHmm();

    // TODO: gọi repository / service lưu Firestore
    debugPrint('Lưu ca:');
    debugPrint('Tên ca: $tenCa');
    debugPrint('Giờ bắt đầu: $gioBatDauStr');
    debugPrint('Giờ kết thúc: $gioKetThucStr');

    Navigator.pop(context);
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
              ButtonAdmin(onPressed: () {}, title: 'Lưu'),
            ],
          ),
        ),
      ),
    );
  }
}
