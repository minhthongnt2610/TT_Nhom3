import 'package:cloud_firestore/cloud_firestore.dart';

class DonTuModel {
  final String id;
  final String userId;
  final String hoTen;
  final String maNV;
  final String phongBanID;
  final String quanLyID;
  final String loaiDon;
  final String lyDo;
  final String tuNgay;
  final String denNgay;
  final String trangThai; // cho_duyet | da_duyet | tu_choi
  final Timestamp ngayTao;

  DonTuModel({
    required this.id,
    required this.userId,
    required this.hoTen,
    required this.maNV,
    required this.phongBanID,
    required this.quanLyID,
    required this.loaiDon,
    required this.lyDo,
    required this.tuNgay,
    required this.denNgay,
    required this.trangThai,
    required this.ngayTao,
  });

  DonTuModel copyWith({
    String? id,
    String? userId,
    String? hoTen,
    String? maNV,
    String? phongBanID,
    String? quanLyID,
    String? loaiDon,
    String? lyDo,
    String? tuNgay,
    String? denNgay,
    String? trangThai,
    Timestamp? ngayTao,
  }) {
    return DonTuModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      hoTen: hoTen ?? this.hoTen,
      maNV: maNV ?? this.maNV,
      phongBanID: phongBanID ?? this.phongBanID,
      quanLyID: quanLyID ?? this.quanLyID,
      loaiDon: loaiDon ?? this.loaiDon,
      lyDo: lyDo ?? this.lyDo,
      tuNgay: tuNgay ?? this.tuNgay,
      denNgay: denNgay ?? this.denNgay,
      trangThai: trangThai ?? this.trangThai,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'hoTen': hoTen,
      'maNV': maNV,
      'phongBanID': phongBanID,
      'quanLyID': quanLyID,
      'loaiDon': loaiDon,
      'lyDo': lyDo,
      'tuNgay': tuNgay,
      'denNgay': denNgay,
      'trangThai': trangThai,
      'ngayTao': ngayTao,
    };
  }
}
