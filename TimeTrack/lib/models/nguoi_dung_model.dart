import 'package:timetrack/models/trang_thai_nguoi_dung_model.dart';

class NguoiDungModel {
  final String id;
  final String hoTen;
  final String email;
  final String chucVu;
  final String phongBanID;
  final String phongBan;
  final String anhDaiDienURL;
  final TrangThaiNguoiDungModel trangThai;
  final DateTime ngayTao;
  const NguoiDungModel({
    required this.id,
    required this.hoTen,
    required this.email,
    required this.chucVu,
    required this.phongBanID,
    required this.phongBan,
    required this.anhDaiDienURL,
    required this.trangThai,
    required this.ngayTao,
  });

  NguoiDungModel copyWith({
    String? id,
    String? hoTen,
    String? email,
    String? chucVu,
    String? phongBanID,
    String? phongBan,
    String? anhDaiDienURL,
    TrangThaiNguoiDungModel? trangThai,
    DateTime? ngayTao,
  }) {
    return NguoiDungModel(
      id: id ?? this.id,
      hoTen: hoTen ?? this.hoTen,
      email: email ?? this.email,
      chucVu: chucVu ?? this.chucVu,
      phongBanID: phongBanID ?? this.phongBanID,
      phongBan: phongBan ?? this.phongBan,
      anhDaiDienURL: anhDaiDienURL ?? this.anhDaiDienURL,
      trangThai: trangThai ?? this.trangThai,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hoTen': hoTen,
      'email': email,
      'chucVu': chucVu,
      'phongBanID': phongBanID,
      'phongBan': phongBan,
      'anhDaiDienURL': anhDaiDienURL,
      'trangThai': trangThai,
      'ngayTao': ngayTao,
    };
  }

  @override
  String toString() {
    return 'NguoiDungModel{id: $id, hoTen: $hoTen, email: $email, chucVu: $chucVu, phongBanID: $phongBanID, phongBan: $phongBan, anhDaiDienURL: $anhDaiDienURL, trangThai: $trangThai, ngayTao: $ngayTao}';
  }
}
