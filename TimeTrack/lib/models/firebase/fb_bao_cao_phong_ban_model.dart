import 'package:timetrack/models/bao_cao_phong_ban_model.dart';

class FbBaoCaoChamCongModel {
  final String id;
  final String hoTen;
  final String maNV;
  final int soNgayLam;
  final int soNgayNghi;

  FbBaoCaoChamCongModel({
    required this.id,
    required this.hoTen,
    required this.maNV,
    required this.soNgayLam,
    required this.soNgayNghi,
  });

  factory FbBaoCaoChamCongModel.fromJson(Map<String, dynamic> json, String id) {
    return FbBaoCaoChamCongModel(
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

extension FbBaoCaoChamCongModelExtension on FbBaoCaoChamCongModel {
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
