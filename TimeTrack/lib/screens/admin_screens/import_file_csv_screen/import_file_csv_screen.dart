import 'dart:io';

import 'package:flutter/material.dart';
import 'package:timetrack/common_widget/button_admin.dart';
import 'package:timetrack/common_widget/button_widget.dart';
import 'package:timetrack/contains/app_colors.dart';

class ImportFileCsvScreen extends StatefulWidget {
  const ImportFileCsvScreen({super.key});

  @override
  State<ImportFileCsvScreen> createState() => _ImportFileCsvScreenState();
}

class _ImportFileCsvScreenState extends State<ImportFileCsvScreen> {
  File? selectedCsv;
  bool uploading = false;
  String statusMessage = "";

  @override
  void initState() {
    super.initState();
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
                    ButtonWidget(onPressed: () {}, title: "Chọn file"),
                    SizedBox(height: 12 * height / 956),
                    if (selectedCsv != null)
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
                                selectedCsv!.path.split("/").last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 12 * height / 956),
                    ButtonAdmin(onPressed: () {}, title: "Upload file"),
                    SizedBox(height: 16 * height / 956),
                    if (statusMessage != null)
                      Text(
                        statusMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'balooPaaji',
                          color: statusMessage.startsWith("L")
                              ? Colors.red
                              : statusMessage.startsWith("U")
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
