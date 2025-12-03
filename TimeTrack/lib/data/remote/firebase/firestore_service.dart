import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/firebase/fb_nguoi_dung_model.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<FbNguoiDungModel> getUser(String userId) {
    return _firebaseFirestore
        .collection('NguoiDung')
        .doc(userId)
        .snapshots()
        .map((doc) => FbNguoiDungModel.fromJson(doc.data()!, doc.id));
  }
}
