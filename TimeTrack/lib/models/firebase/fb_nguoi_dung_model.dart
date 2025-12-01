import '../trang_thai_nguoi_dung_model.dart';

class FbNguoiDungModel{
  final String id;
  final String hoTen;
  final String ma;
  final String email;
  final String chucVu;
  final String phongBanID;
  final String phongBan;
  final String anhDaiDienURL;
  final int trangThai;
  final DateTime ngayTao;
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
  });
  FbNguoiDungModel copyWith({
    String? id,
    String? hoTen,
    String? ma,
    String? email,
    String? chucVu,
    String? phongBanID,
    String? phongBan,
    String? anhDaiDienURL,
    int? trangThai,
    DateTime? ngayTao,
})
  {
    return FbNguoiDungModel(
      id: id ?? this.id,
      hoTen: hoTen ?? this.hoTen,
      email: email ?? this.email,
      chucVu: chucVu ?? this.chucVu,
      ma: ma ?? this.ma,
      phongBanID: phongBanID ?? this.phongBanID,
      phongBan: phongBan ?? this.phongBan,
      anhDaiDienURL: anhDaiDienURL ?? this.anhDaiDienURL,
      trangThai: trangThai ?? this.trangThai,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }
  Map<String,dynamic> toJson(){
    return {
      // 'id': id,
      'hoTen': hoTen,
      'email': email,
      'chucVu': chucVu,
      'chucVu': chucVu,
      'phongBanID': phongBanID,
      'phongBan': phongBan,
      'anhDaiDienURL': anhDaiDienURL,
      'trangThai': trangThai,
      'ngayTao': ngayTao,
    };
  }
  factory FbNguoiDungModel.fromJson(Map<String, dynamic> json, String id){
    return FbNguoiDungModel(
      id: id,
      hoTen: json['hoTen'],
      email: json['email'],
      ma: json['ma'],
      chucVu: json['chucVu'],
      phongBanID: json['phongBanID'],
      phongBan: json['phongBan'],
      anhDaiDienURL: json['anhDaiDienURL'],
      trangThai: json['trangThai'],
      ngayTao: json['ngayTao'],
    );
  }
}