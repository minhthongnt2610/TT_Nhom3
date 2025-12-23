import 'package:timetrack/extensions/date_time_extension.dart';

import '../thoi_gian_lam_viec_model.dart';

class FbThoiGianLamViecModel {
  final String id;
  final String tenCa;
  final String gioBatDau; // "07:00"
  final String gioKetThuc; // "23:59"

  const FbThoiGianLamViecModel({
    required this.id,
    required this.tenCa,
    required this.gioBatDau,
    required this.gioKetThuc,
  });

  factory FbThoiGianLamViecModel.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return FbThoiGianLamViecModel(
      id: id,
      tenCa: json['tenCa'] ?? '',
      gioBatDau: json['gioBatDau'] ?? '00:00',
      gioKetThuc: json['gioKetThuc'] ?? '00:00',
    );
  }

  Map<String, dynamic> toJson() {
    return {'tenCa': tenCa, 'gioBatDau': gioBatDau, 'gioKetThuc': gioKetThuc};
  }
}

extension FbThoiGianLamViecExtension on FbThoiGianLamViecModel {
  ThoiGianLamViecModel toThoiGianLamViecModel() {
    return ThoiGianLamViecModel(
      id: id,
      tenCa: tenCa,
      gioBatDau: gioBatDau.toTimeOfDay(),
      gioKetThuc: gioKetThuc.toTimeOfDay(),
    );
  }
}
