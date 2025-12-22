import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/common_widget/button_widget.dart';
import 'package:timetrack/contains/app_colors.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/data/remote/firebase/storage_service.dart';

class ImportFileCsvScreen extends StatefulWidget {
  const ImportFileCsvScreen({super.key});

  @override
  State<ImportFileCsvScreen> createState() => _ImportFileCsvScreenState();
}

class _ImportFileCsvScreenState extends State<ImportFileCsvScreen> {
  File? selectFile;
  bool uploading = false;
  String notice = "";
  bool isAdmin = false;
  final authService = AuthService();
  final storageService = StorageService();

  @override
  void initState() {
    super.initState();
    checkRole();
  }

  Future<void> checkRole() async {
    final result = await authService.checkAdmin();
    setState(() => isAdmin = result);
  }

  Future<void> chooseFileCSV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"],
    );

    if (result != null) {
      setState(() {
        selectFile = File(result.files.single.path!);
        notice = "Đã chọn file CSV";
      });
    }
  }

  Future<void> importFileCSV() async {
    if (selectFile == null) {
      setState(() => notice = "Vui lòng chọn file CSV trước");
      return;
    }

    setState(() {
      uploading = true;
      notice = "Đang upload file CSV...";
    });

    try {
      await storageService.importFileCSV(selectFile!);
      setState(() {
        uploading = false;
        notice = "Upload thành công! File sẽ được xử lý tự động.";
      });
    } catch (e) {
      setState(() {
        uploading = false;
        notice = "Lỗi upload: $e";
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
        centerTitle: true,
        title: const Text(
          "IMPORT FILE CSV",
          style: TextStyle(
            color: AppColors.backgroundAppBar,
            fontSize: 20,
            fontFamily: 'balooPaaji',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420 * width / 440),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Import file CSV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'balooPaaji',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8 * height / 956),
                    ButtonWidget(
                      onPressed: () {
                        uploading ? null : chooseFileCSV();
                      },
                      title: "Chọn file",
                    ),
                    SizedBox(height: 12 * height / 956),
                    if (selectFile != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.description, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                selectFile!.path.split("/").last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 12 * height / 956),
                    ButtonAdmin(
                      onPressed: () {
                        uploading ? null : importFileCSV();
                      },
                      title: "Upload file",
                    ),
                    SizedBox(height: 16 * height / 956),
                    if (notice != null)
                      Text(
                        notice,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'balooPaaji',
                          color: notice.startsWith("L")
                              ? Colors.red
                              : notice.startsWith("U")
                              ? Colors.green
                              : Colors.blueGrey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
