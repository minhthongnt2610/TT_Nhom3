import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/firebase/fb_nguoi_dung_model.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirestoreService(){
    log('FirestoreService created');
}
  // Stream<FbNguoiDungModel> getUser(String userId) {
  //   return _firebaseFirestore
  //       .collection('NguoiDung')
  //       .doc(userId)
  //       .snapshots()
  //       .map((doc) => FbNguoiDungModel.fromJson(doc.data()!, doc.id));
  // }
  Stream<FbNguoiDungModel?> getUser(String userId) {
    return _firebaseFirestore
        .collection('NguoiDung')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return FbNguoiDungModel.fromJson(doc.data()!, doc.id);
    });
  }
}
