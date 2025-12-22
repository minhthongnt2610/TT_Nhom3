import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/khu_vuc_cham_cong_model.dart';

class FbKhuVucChamCongModel {
  final String id;
  final String tenKhuVuc;
  final double banKinh;
  final GeoPoint toaDo;
  final int ngayTao;

  const FbKhuVucChamCongModel({
    required this.id,
    required this.tenKhuVuc,
    required this.banKinh,
    required this.toaDo,
    required this.ngayTao,
  });

  factory FbKhuVucChamCongModel.fromJson(Map<String, dynamic> json, String id) {
    return FbKhuVucChamCongModel(
      id: id,
      tenKhuVuc: json['tenKhuVuc'] ?? '',
      banKinh: (json['banKinh'] as num).toDouble(),
      toaDo: json['toaDo'] ?? '',
      ngayTao: json['ngayTao'] is Timestamp
          ? (json['ngayTao'] as Timestamp).millisecondsSinceEpoch
          : (json['ngayTao'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenKhuVuc': tenKhuVuc,
      'banKinh': banKinh,
      'toaDo': toaDo,
      'ngayTao': ngayTao,
    };
  }
}

extension FbKhuVucChamCongModelExtension on FbKhuVucChamCongModel {
  KhuVucChamCongModel toKhuVucChamCongModel() {
    return KhuVucChamCongModel(
      id: id,
      tenKhuVuc: tenKhuVuc,
      banKinh: banKinh,
      toaDo: toaDo,
      ngayTao: DateTime.fromMillisecondsSinceEpoch(ngayTao),
    );
  }
}
