import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/data/remote/firebase/storage_service.dart';

class ImportFileCsvScreen extends StatefulWidget {
  const ImportFileCsvScreen({super.key});
  @override
  State<ImportFileCsvScreen> createState() => _ImportFileCsvScreenState();
}

class _ImportFileCsvScreenState extends State<ImportFileCsvScreen> {
  File? selectedCsv;
  bool uploading = false;
  String statusMessage = "";
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
    setState(() {
      isAdmin = result;
    });
  }

  /// Chọn file CSV từ máy
  Future<void> pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedCsv = File(result.files.single.path!);
        statusMessage = "File đã chọn: ${result.files.single.name}";
      });
    }
  }

  Future<void> importFileCSV() async {
    if (selectedCsv == null) {
      setState(() => statusMessage = "Vui lòng chọn file CSV trước.");
      return;
    }
    setState(() {
      uploading = true;
      statusMessage = "Đang upload...";
    });
    try {
      await storageService.importFileCSV(selectedCsv!);
      setState(() {
        uploading = false;
        statusMessage = "Upload thành công! CSV sẽ được xử lý tự động.";
      });
    } catch (e) {
      setState(() {
        uploading = false;
        statusMessage = "Lỗi upload: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu không phải admin → chặn màn hình
    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text("Import CSV")),
        body: Center(
          child: Text(statusMessage, style: const TextStyle(fontSize: 16)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Import CSV cho Admin")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.attach_file),
              label: const Text("Chọn file CSV"),
              onPressed: pickCsvFile,
            ),

            const SizedBox(height: 20),

            if (selectedCsv != null)
              Text(
                "File: ${selectedCsv!.path.split("/").last}",
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.cloud_upload),
              label: uploading
                  ? const Text("Đang upload...")
                  : const Text("Upload CSV"),
              onPressed: uploading ? null : importFileCSV,
            ),

            const SizedBox(height: 40),

            Text(
              statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
