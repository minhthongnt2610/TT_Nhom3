import 'package:cloud_firestore/cloud_firestore.dart';

class ChamCongModel {
  final String id;
  final String userId;
  final String khuVucId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final GeoPoint? checkInLocation;
  final GeoPoint? checkOutLocation;
  final String? trangThai;
  final String ngay;

  const ChamCongModel({
    required this.id,
    required this.userId,
    required this.khuVucId,
    required this.checkInTime,
    required this.checkOutTime,
    required this.checkInLocation,
    required this.checkOutLocation,
    required this.trangThai,
    required this.ngay,
  });

  ChamCongModel copyWith({
    String? id,
    String? userId,
    String? khuVucId,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    GeoPoint? checkInLocation,
    GeoPoint? checkOutLocation,
    String? trangThai,
    String? ngay,
  }) {
    return ChamCongModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      khuVucId: khuVucId ?? this.khuVucId,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      checkInLocation: checkInLocation ?? this.checkInLocation,
      checkOutLocation: checkOutLocation ?? this.checkOutLocation,
      trangThai: trangThai ?? this.trangThai,
      ngay: ngay ?? this.ngay,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'khuVucId': khuVucId,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'checkInLocation': checkInLocation,
      'checkOutLocation': checkOutLocation,
      'trangThai': trangThai,
      'ngay': ngay,
    };
  }

  @override
  String toString() {
    return 'ChamCongModel{id: $id, userId: $userId, khuVucId: $khuVucId, checkInTime: $checkInTime, checkOutTime: $checkOutTime, checkInLocation: $checkInLocation, checkOutLocation: $checkOutLocation, trangThai: $trangThai, ngay: $ngay}';
  }
}
