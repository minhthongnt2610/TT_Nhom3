import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetrack/models/cham_cong_model.dart';

class FbChamCongModel {
  final String id;
  final String userId;
  final String khuVucId;
  final int checkInTime;
  final int? checkOutTime;
  final GeoPoint? checkInLocation;
  final GeoPoint? checkOutLocation;
  final String trangThai;
  final String ngay;

  const FbChamCongModel({
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

  factory FbChamCongModel.fromJson(Map<String, dynamic> json, String id) {
    return FbChamCongModel(
      id: id,
      userId: json['userId'] ?? '',
      khuVucId: json['khuVucId'] ?? '',
      checkInTime: json['checkInTime'] is Timestamp
          ? (json['checkInTime'] as Timestamp).millisecondsSinceEpoch
          : json['checkInTime'],
      checkOutTime: json['checkOutTime'] is Timestamp
          ? (json['checkOutTime'] as Timestamp).millisecondsSinceEpoch
          : json['checkOutTime'],
      checkInLocation: json['checkInLocation'] as GeoPoint,
      checkOutLocation: json['checkOutLocation'] != null
          ? json['checkOutLocation'] as GeoPoint
          : null,
      trangThai: json['trangThai'] ?? '',
      ngay: json['ngay'] ?? '',
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
}

extension FbChamCongModelExtension on FbChamCongModel {
  ChamCongModel toChamCongModel() {
    return ChamCongModel(
      id: id,
      userId: userId,
      khuVucId: khuVucId,
      checkInTime: DateTime.fromMillisecondsSinceEpoch(checkInTime),
      checkOutTime: DateTime.fromMillisecondsSinceEpoch(checkOutTime!),
      checkInLocation: checkInLocation,
      checkOutLocation: checkOutLocation,
      trangThai: trangThai,
      ngay: ngay.toString(),
    );
  }
}
