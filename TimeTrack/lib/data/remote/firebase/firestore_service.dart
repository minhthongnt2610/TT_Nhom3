import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/firebase/fb_bao_cao_phong_ban_model.dart';
import 'package:timetrack/models/firebase/fb_bao_cao_tong_hop_model.dart';
import 'package:timetrack/models/firebase/fb_cham_cong_model.dart';
import 'package:timetrack/models/firebase/fb_don_tu_model.dart';
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

  Stream<List<FbChamCongModel>> getLichSuChamCong(String userId) {
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

  Stream<List<FbNguoiDungModel>> getNhanVienPhongBan(String phongBanId) {
    return _firebaseFirestore
        .collection('NguoiDung')
        .where('phongBanID', isEqualTo: phongBanId)
        .where('vaiTro', isEqualTo: 'nhanvien')
        .snapshots()
        .map((snap) {
          return snap.docs
              .map((doc) => FbNguoiDungModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  Stream<List<FbNguoiDungModel>> getAllNhanVienVaQuanLy(String id) {
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

  Future<List<FbBaoCaoPhongBanModel>> quanLyBaoCaoPhongBan({
    required String phongBanId,
    required String tuNgay,
    required String denNgay,
  }) async {
    final nhanVienTrongPhongBan = await _firebaseFirestore
        .collection('NguoiDung')
        .where('phongBanID', isEqualTo: phongBanId)
        .where('vaiTro', isEqualTo: 'nhanvien')
        .get();
    List<FbBaoCaoPhongBanModel> result = [];
    for (final nv in nhanVienTrongPhongBan.docs) {
      final user = nv.data();
      final id = nv.id;
      final chamCong = await _firebaseFirestore
          .collection('ChamCong')
          .where('userId', isEqualTo: id)
          .where('ngay', isGreaterThanOrEqualTo: tuNgay)
          .where('ngay', isLessThanOrEqualTo: denNgay)
          .get();

      int soNgayLam = chamCong.docs.length;
      int tongNgay =
          (DateTime.parse(denNgay).difference(DateTime.parse(tuNgay)).inDays +
          1);
      int soNgayNghi = tongNgay - soNgayLam;

      result.add(
        FbBaoCaoPhongBanModel(
          id: id,
          hoTen: user['hoTen'],
          maNV: user['ma'],
          soNgayLam: soNgayLam,
          soNgayNghi: soNgayNghi < 0 ? 0 : soNgayNghi,
        ),
      );
    }
    return result;
  }

  Future<List<FbBaoCaoTongHopModel>> hrBaoCaoPhongBan({
    required String tuNgay,
    required String denNgay,
  }) async {
    final allNhanVien = await _firebaseFirestore
        .collection('NguoiDung')
        .where('vaiTro', whereIn: ['nhanvien', 'quanly'])
        .get();
    List<FbBaoCaoTongHopModel> result = [];
    for (final nv in allNhanVien.docs) {
      final user = nv.data();
      final id = nv.id;
      final chamCong = await _firebaseFirestore
          .collection('ChamCong')
          .where('userId', isEqualTo: id)
          .where('ngay', isGreaterThanOrEqualTo: tuNgay)
          .where('ngay', isLessThanOrEqualTo: denNgay)
          .get();

      int soNgayLam = chamCong.docs.length;
      int tongNgay =
          (DateTime.parse(denNgay).difference(DateTime.parse(tuNgay)).inDays +
          1);
      int soNgayNghi = tongNgay - soNgayLam;

      result.add(
        FbBaoCaoTongHopModel(
          id: id,
          hoTen: user['hoTen'],
          maNV: user['ma'],
          soNgayLam: soNgayLam,
          soNgayNghi: soNgayNghi < 0 ? 0 : soNgayNghi,
          phongBan: user['phongBan'],
        ),
      );
    }
    return result;
  }

  // Future<void> taoDonTu({
  //   required String userId,
  //   required String loaiDon,
  //   required String lyDo,
  //   required String tuNgay,
  //   required String denNgay,
  // }) async {
  //   final user = await getUser(userId);
  //   final quanLy = await _firebaseFirestore
  //       .collection('NguoiDung')
  //       .where('phongBanID', isEqualTo: user!.phongBanID)
  //       .where('vaiTro', isEqualTo: 'quanly')
  //       .limit(1)
  //       .get();
  //   final idQuanLy = quanLy.docs.first.id;
  //   await _firebaseFirestore.collection('DonTu').add({
  //     'userId': user.id,
  //     'hoTen': user.hoTen,
  //     'maNV': user.ma,
  //     'phongBanID': user.phongBanID,
  //     'quanLyID': idQuanLy,
  //     'loaiDon': loaiDon,
  //     'lyDo': lyDo,
  //     'tuNgay': tuNgay,
  //     'denNgay': denNgay,
  //     'trangThai': 'cho_duyet',
  //   });
  // }

  Stream<List<FbDonTuModel>> donChoDuyet({required String idQuanLy}) {
    return _firebaseFirestore
        .collection('DonTu')
        .where('quanLyID', isEqualTo: idQuanLy)
        .where('trangThai', isEqualTo: 'cho_duyet')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => FbDonTuModel.fromJson(d.data(), d.id))
              .toList(),
        );
  }

  Future<void> duyetDon({
    required String idDon,
    required bool trangThai,
  }) async {
    await _firebaseFirestore.collection('DonTu').doc(idDon).update({
      'trangThai': trangThai ? 'da_duyet' : 'tu_choi',
    });
  }

  Stream<List<FbDonTuModel>> getDonCuaNV({required String nvId}) {
    return _firebaseFirestore
        .collection('DonTu')
        .where('userId', isEqualTo: nvId)
        .orderBy('ngayTao', descending: true)
        .snapshots()
        .map((snap) {
          return snap.docs
              .map((doc) => FbDonTuModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }
}
