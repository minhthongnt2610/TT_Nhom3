import 'package:flutter/material.dart';
import 'package:timetrack/extensions/date_time_extension.dart';

import 'firebase/fb_thoi_gian_lam_viec_model.dart';

class ThoiGianLamViecModel {
  final String id;
  final String tenCa;
  final TimeOfDay gioBatDau;
  final TimeOfDay gioKetThuc;

  const ThoiGianLamViecModel({
    required this.id,
    required this.tenCa,
    required this.gioBatDau,
    required this.gioKetThuc,
  });

  ThoiGianLamViecModel copyWith({
    String? id,
    String? tenCa,
    TimeOfDay? gioBatDau,
    TimeOfDay? gioKetThuc,
  }) {
    return ThoiGianLamViecModel(
      id: id ?? this.id,
      tenCa: tenCa ?? this.tenCa,
      gioBatDau: gioBatDau ?? this.gioBatDau,
      gioKetThuc: gioKetThuc ?? this.gioKetThuc,
    );
  }

  @override
  String toString() {
    return 'ThoiGianLamViecModel(id: $id, tenCa: $tenCa, '
        'gioBatDau: ${gioBatDau.toHHmm()}, '
        'gioKetThuc: ${gioKetThuc.toHHmm()})';
  }
}

extension ThoiGianLamViecToFbExtension on ThoiGianLamViecModel {
  FbThoiGianLamViecModel toFbThoiGianLamViecModel() {
    return FbThoiGianLamViecModel(
      id: id,
      tenCa: tenCa,
      gioBatDau: gioBatDau.toHHmm(),
      gioKetThuc: gioKetThuc.toHHmm(),
    );
  }
}
