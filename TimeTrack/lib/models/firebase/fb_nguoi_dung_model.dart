import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/nguoi_dung_model.dart';
import '../trang_thai_nguoi_dung_model.dart';

class FbNguoiDungModel {
  final String id;
  final String hoTen;
  final String ma;
  final String email;
  final String chucVu;
  final String phongBanID;
  final String phongBan;
  final String anhDaiDienURL;
  final int trangThai;
  final int ngayTao;
  final String vaiTro;

  const FbNguoiDungModel({
    required this.id,
    required this.hoTen,
    required this.ma,
    required this.email,
    required this.chucVu,
    required this.phongBanID,
    required this.phongBan,
    required this.anhDaiDienURL,
    required this.trangThai,
    required this.ngayTao,
    required this.vaiTro,
  });

  factory FbNguoiDungModel.fromJson(Map<String, dynamic> json, String id) {
    return FbNguoiDungModel(
      id: id,
      hoTen: json['hoTen'] ?? '',
      email: json['email'] ?? '',
      ma: json['ma'] ?? '',
      chucVu: json['chucVu'] ?? '',
      phongBanID: json['phongBanID'] ?? '',
      phongBan: json['phongBan'] ?? '',
      anhDaiDienURL: json['anhDaiDienURL'] ?? '',
      trangThai: json['trangThai'] ?? 0,
      ngayTao: json['ngayTao'] is Timestamp
          ? (json['ngayTao'] as Timestamp).millisecondsSinceEpoch
          : (json['ngayTao'] ?? 0),
      vaiTro: json['vaiTro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'email': email,
      'chucVu': chucVu,
      'ma': ma,
      'phongBanID': phongBanID,
      'phongBan': phongBan,
      'anhDaiDienURL': anhDaiDienURL,
      'trangThai': trangThai,
      'ngayTao': ngayTao,
      'vaiTro': vaiTro,
    };
  }
}

extension FbNguoiDungModelExtension on FbNguoiDungModel {
  NguoiDungModel toNguoiDungModel() {
    return NguoiDungModel(
      id: id,
      hoTen: hoTen,
      email: email,
      chucVu: chucVu,
      ma: ma,
      phongBanID: phongBanID,
      phongBan: phongBan,
      anhDaiDienURL: anhDaiDienURL,
      trangThai: TrangThaiNguoiDungModel.values[trangThai],
      ngayTao: DateTime.fromMillisecondsSinceEpoch(ngayTao),
      vaiTro: vaiTro,
    );
  }
}
