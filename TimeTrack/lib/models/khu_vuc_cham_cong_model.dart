import 'package:cloud_firestore/cloud_firestore.dart';

class KhuVucChamCongModel {
  final String id;
  final String tenKhuVuc;
  final double banKinh;
  final GeoPoint toaDo;
  final DateTime ngayTao;

  const KhuVucChamCongModel({
    required this.id,
    required this.tenKhuVuc,
    required this.banKinh,
    required this.toaDo,
    required this.ngayTao,
  });

  KhuVucChamCongModel copyWith({
    String? id,
    String? tenKhuVuc,
    double? banKinh,
    GeoPoint? toaDo,
    DateTime? ngayTao,
  }) {
    return KhuVucChamCongModel(
      id: id ?? this.id,
      tenKhuVuc: tenKhuVuc ?? this.tenKhuVuc,
      banKinh: banKinh ?? this.banKinh,
      toaDo: toaDo ?? this.toaDo,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenKhuVuc': tenKhuVuc,
      'banKinh': banKinh,
      'toaDo': toaDo,
      'ngayTao': ngayTao,
    };
  }

  @override
  String toString() {
    return 'KhuVucChamCongModel{id: $id, tenKhuVuc: $tenKhuVuc, banKinh: $banKinh, toaDo: $toaDo, ngayTao: $ngayTao}';
  }
}
