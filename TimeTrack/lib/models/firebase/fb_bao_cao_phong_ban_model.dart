import 'package:timetrack/models/bao_cao_phong_ban_model.dart';

class FbBaoCaoPhongBanModel {
  final String id;
  final String hoTen;
  final String maNV;
  final int soNgayLam;
  final int soNgayNghi;

  FbBaoCaoPhongBanModel({
    required this.id,
    required this.hoTen,
    required this.maNV,
    required this.soNgayLam,
    required this.soNgayNghi,
  });

  factory FbBaoCaoPhongBanModel.fromJson(Map<String, dynamic> json, String id) {
    return FbBaoCaoPhongBanModel(
      id: id,
      hoTen: json['hoTen'] ?? '',
      maNV: json['maNV'] ?? '',
      soNgayLam: json['soNgayLam'] ?? 0,
      soNgayNghi: json['soNgayNghi'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'maNV': maNV,
      'soNgayLam': soNgayLam,
      'soNgayNghi': soNgayNghi,
    };
  }
}

extension FbBaoCaoPhongBanModelExtension on FbBaoCaoPhongBanModel {
  BaoCaoChamCongModel toBaoCaoChamCongModel() {
    return BaoCaoChamCongModel(
      id: id,
      hoTen: hoTen,
      maNV: maNV,
      soNgayLam: soNgayLam,
      soNgayNghi: soNgayNghi,
    );
  }
}
