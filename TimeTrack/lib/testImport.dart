import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImportCsvScreen extends StatefulWidget {
  const ImportCsvScreen({super.key});

  @override
  State<ImportCsvScreen> createState() => _ImportCsvScreenState();
}

class _ImportCsvScreenState extends State<ImportCsvScreen> {
  File? selectedCsv;
  bool uploading = false;
  String statusMessage = "";
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkAdminRole();
  }

  /// Kiểm tra custom claim "role"
  Future<void> checkAdminRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => statusMessage = "Bạn chưa đăng nhập");
      return;
    }

    // Refresh token để lấy custom claims mới
    final idTokenResult = await user.getIdTokenResult(true);
    final role = idTokenResult.claims?["role"];

    if (role == "admin") {
      setState(() => isAdmin = true);
    } else {
      setState(() => statusMessage = "Bạn không có quyền admin để import CSV");
    }
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

  /// Upload file vào Firebase Storage
  Future<void> uploadCsv() async {
    if (selectedCsv == null) {
      setState(() => statusMessage = "Vui lòng chọn file CSV trước.");
      return;
    }

    setState(() {
      uploading = true;
      statusMessage = "Đang upload...";
    });

    try {
      final fileName = selectedCsv!.path.split("/").last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("imports/$fileName"); // Cloud Functions sẽ xử lý file

      await storageRef.putFile(selectedCsv!);

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
          child: Text(
            statusMessage,
            style: const TextStyle(fontSize: 16),
          ),
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
              onPressed: uploading ? null : uploadCsv,
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
