import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<bool> importFileCSV(File file) async {
    try {
      final fileName = file.path.split("/").last;
      final ref = storage.ref().child("imports/$fileName");
      await ref.putFile(file);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
