import '../thoi_gian_lam_viec_model.dart';

class FbKhuVucChamCongModel {
  final String id;
  final String tenCa;
  final String gioBatDau;
  final String gioKetThuc;

  const FbKhuVucChamCongModel({
    required this.id,
    required this.tenCa,
    required this.gioBatDau,
    required this.gioKetThuc,
  });

  factory FbKhuVucChamCongModel.fromJson(Map<String, dynamic> json, String id) {
    return FbKhuVucChamCongModel(
      id: id,
      tenCa: json['tenCa'] ?? '',
      gioBatDau: json['gioBatDau'] ?? '',
      gioKetThuc: json['gioKetThuc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'tenCa': tenCa, 'gioBatDau': gioBatDau, 'gioKetThuc': gioKetThuc};
  }
}

extension FbThoiGianLamViecModelExtension on FbKhuVucChamCongModel {
  ThoiGianLamViecModel toThoiGianLamViecModel() {
    return ThoiGianLamViecModel(
      id: id,
      tenCa: tenCa,
      gioBatDau: DateTime.parse(gioBatDau),
      gioKetThuc: DateTime.parse(gioKetThuc),
    );
  }
}
