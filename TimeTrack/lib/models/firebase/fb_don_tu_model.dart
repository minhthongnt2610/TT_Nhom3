import '../don_tu_model.dart';

class FbDonTuModel {
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

  const FbDonTuModel({
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
  });

  factory FbDonTuModel.fromJson(Map<String, dynamic> json, String id) {
    return FbDonTuModel(
      id: id,
      userId: json['userId'] ?? '',
      hoTen: json['hoTen'] ?? '',
      maNV: json['maNV'] ?? '',
      phongBanID: json['phongBanID'] ?? '',
      quanLyID: json['quanLyID'] ?? '',
      loaiDon: json['loaiDon'] ?? '',
      lyDo: json['lyDo'] ?? '',
      tuNgay: json['tuNgay'] ?? '',
      denNgay: json['denNgay'] ?? '',
      trangThai: json['trangThai'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}

extension FbDonTuModelExtension on FbDonTuModel {
  DonTuModel toDonTuModel() {
    return DonTuModel(
      id: id,
      userId: userId,
      hoTen: hoTen,
      maNV: maNV,
      phongBanID: phongBanID,
      quanLyID: quanLyID,
      loaiDon: loaiDon,
      lyDo: lyDo,
      tuNgay: tuNgay,
      denNgay: denNgay,
      trangThai: trangThai,
    );
  }
}
