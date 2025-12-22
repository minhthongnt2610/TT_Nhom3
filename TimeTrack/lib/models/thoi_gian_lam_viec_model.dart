class ThoiGianLamViecModel {
  final String id;
  final String tenCa;
  final DateTime gioBatDau;
  final DateTime gioKetThuc;

  const ThoiGianLamViecModel({
    required this.id,
    required this.tenCa,
    required this.gioBatDau,
    required this.gioKetThuc,
  });

  ThoiGianLamViecModel copyWith({
    String? id,
    String? tenCa,
    DateTime? gioBatDau,
    DateTime? gioKetThuc,
  }) {
    return ThoiGianLamViecModel(
      id: id ?? this.id,
      tenCa: tenCa ?? this.tenCa,
      gioBatDau: gioBatDau ?? this.gioBatDau,
      gioKetThuc: gioKetThuc ?? this.gioKetThuc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenCa': tenCa,
      'gioBatDau': gioBatDau,
      'gioKetThuc': gioKetThuc,
    };
  }

  @override
  String toString() {
    return 'ThoiGianLamViecModel{id: $id, tenCa: $tenCa, gioBatDau: $gioBatDau, gioKetThuc: $gioKetThuc}';
  }
}
