import '../bao_cao_tong_hop_model.dart';

class FbBaoCaoTongHopModel {
  final String id;
  final String hoTen;
  final String maNV;
  final int soNgayLam;
  final int soNgayNghi;
  final String phongBan;

  FbBaoCaoTongHopModel({
    required this.id,
    required this.hoTen,
    required this.maNV,
    required this.soNgayLam,
    required this.soNgayNghi,
    required this.phongBan,
  });

  factory FbBaoCaoTongHopModel.fromJson(Map<String, dynamic> json, String id) {
    return FbBaoCaoTongHopModel(
      id: id,
      hoTen: json['hoTen'] ?? '',
      maNV: json['maNV'] ?? '',
      soNgayLam: json['soNgayLam'] ?? 0,
      soNgayNghi: json['soNgayNghi'] ?? 0,
      phongBan: json['phongBan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'maNV': maNV,
      'soNgayLam': soNgayLam,
      'soNgayNghi': soNgayNghi,
      'phongBan': phongBan,
    };
  }
}

extension FbBaoCaoTongHopModelExtension on FbBaoCaoTongHopModel {
  BaoCaoTongHopModel toBaoCaoTongHopModel() {
    return BaoCaoTongHopModel(
      id: id,
      hoTen: hoTen,
      maNV: maNV,
      soNgayLam: soNgayLam,
      soNgayNghi: soNgayNghi,
      phongBan: phongBan,
    );
  }
}
