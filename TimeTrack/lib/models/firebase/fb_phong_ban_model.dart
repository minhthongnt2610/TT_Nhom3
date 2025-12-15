import 'package:cloud_firestore/cloud_firestore.dart';

import '../phong_ban_model.dart';

class FbPhongBanModel {
  final String id;
  final String tenPhongBan;
  final int ngayTao;

  const FbPhongBanModel({
    required this.id,
    required this.tenPhongBan,
    required this.ngayTao,
  });

  factory FbPhongBanModel.fromJson(Map<String, dynamic> json, String id) {
    return FbPhongBanModel(
      id: id,
      tenPhongBan: json['tenPhongBan'] ?? '',
      ngayTao: json['ngayTao'] is Timestamp
          ? (json['ngayTao'] as Timestamp).millisecondsSinceEpoch
          : (json['ngayTao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'tenPhongBan': tenPhongBan, 'ngayTao': ngayTao};
  }
}

extension FbPhongBanModelExtension on FbPhongBanModel {
  PhongBanModel toPhongBanModel() {
    return PhongBanModel(
      id: id,
      tenPhongBan: tenPhongBan,
      ngayTao: DateTime.fromMillisecondsSinceEpoch(ngayTao),
    );
  }
}
