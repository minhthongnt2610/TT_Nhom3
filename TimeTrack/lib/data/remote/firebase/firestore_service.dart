import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/firebase/fb_cham_cong_model.dart';
import 'package:timetrack/models/firebase/fb_khu_vuc_cham_cong_model.dart';
import 'package:timetrack/models/firebase/fb_nguoi_dung_model.dart';
import 'package:timetrack/models/firebase/fb_thoi_gian_lam_viec_model.dart';
import 'package:timetrack/models/thoi_gian_lam_viec_model.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal() {
    log('FirestoreService created');
  }

  Future<FbNguoiDungModel?> getUser(String uid) async {
    final doc = await _firebaseFirestore.collection('NguoiDung').doc(uid).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return FbNguoiDungModel.fromJson(doc.data()!, doc.id);
  }

  Stream<List<FbChamCongModel>> getHistoryAttendance(String userId) {
    return _firebaseFirestore
        .collection('ChamCong')
        .where('userId', isEqualTo: userId)
        .orderBy('ngay', descending: true)
        .snapshots()
        .map((snaps) {
          return snaps.docs
              .map((doc) => FbChamCongModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  // Future<FbChamCongModel?> getChamCong(String userId) async {
  //   final snap = await _firebaseFirestore
  //       .collection('ChamCong')
  //       .where('userId', isEqualTo: userId)
  //       .orderBy('ngay', descending: true)
  //       .limit(1)
  //       .get();
  //   if (snap.docs.isEmpty) {
  //     return null;
  //   }
  //   final doc = snap.docs.first;
  //   return FbChamCongModel.fromJson(doc.data(), doc.id);
  // }

  Stream<List<FbNguoiDungModel>> getEmployeeDepartment(String id) {
    return _firebaseFirestore
        .collection('NguoiDung')
        .where('phongBanID', isEqualTo: id)
        .where('vaiTro', isEqualTo: 'nhanvien')
        .snapshots()
        .map((snap) {
          return snap.docs
              .map((doc) => FbNguoiDungModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  Stream<List<FbNguoiDungModel>> getAll(String id) {
    return _firebaseFirestore
        .collection('NguoiDung')
        .where('vaiTro', whereIn: ['nhanvien', 'quanly'])
        .snapshots()
        .map((snap) {
          return snap.docs
              .map((doc) => FbNguoiDungModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  Future<FbKhuVucChamCongModel?> getKvcc() async {
    final snap = await _firebaseFirestore
        .collection('KhuVucChamCong')
        .orderBy('ngayTao', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) {
      log('Chưa có khu vực chấm công');
      return null;
    }
    final doc = snap.docs.first;
    return FbKhuVucChamCongModel.fromJson(doc.data(), doc.id);
  }

  Future<void> updateKvcc({
    required String id,
    required String tenKhuVuc,
    required double lat,
    required double lon,
    required double banKinh,
  }) async {
    await _firebaseFirestore.collection('KhuVucChamCong').doc(id).update({
      'tenKhuVuc': tenKhuVuc,
      'toaDo': GeoPoint(lat, lon),
      'banKinh': banKinh,
    });
  }

  Stream<List<FbThoiGianLamViecModel>> getThoiGianLamViec() {
    return _firebaseFirestore.collection('ThoiGianLamViec').snapshots().map((
      snap,
    ) {
      return snap.docs
          .map((doc) => FbThoiGianLamViecModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addThoiGianLamViec(ThoiGianLamViecModel model) async {
    await _firebaseFirestore
        .collection('ThoiGianLamViec')
        .add(model.toFbThoiGianLamViecModel().toJson());
  }

  Future<void> updateThoiGianLamViec(ThoiGianLamViecModel model) async {
    await FirebaseFirestore.instance
        .collection('ThoiGianLamViec')
        .doc(model.id)
        .update(model.toFbThoiGianLamViecModel().toJson());
  }

  Future<void> deleteThoiGianLamViec(String id) async {
    await _firebaseFirestore.collection('ThoiGianLamViec').doc(id).delete();
  }

  Future<FbNguoiDungModel?> updateNhanVien({
    required String id,
    required String tenUser,
    required String maUser,
    required String vaiTro,
    required String phongBan,
    required String maPhongBan,
  }) async {
    await _firebaseFirestore.collection('NguoiDung').doc(id).update({
      'hoTen': tenUser,
      'ma': maUser,
      'vaiTro': vaiTro,
      'phongBan': phongBan,
      'phongBanID': maPhongBan,
    });
  }

  Future<void> deleteNhanVien(String id) async {
    await _firebaseFirestore.collection('NguoiDung').doc(id).delete();
  }
}
