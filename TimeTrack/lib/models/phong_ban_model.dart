class PhongBanModel {
  final String id;
  final String tenPhongBan;
  final DateTime ngayTao;

  PhongBanModel({
    required this.id,
    required this.tenPhongBan,
    required this.ngayTao,
  });

  PhongBanModel copyWith({String? id, String? tenPhongBan, DateTime? ngayTao}) {
    return PhongBanModel(
      id: id ?? this.id,
      tenPhongBan: tenPhongBan ?? this.tenPhongBan,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'tenPhongBan': tenPhongBan, 'ngayTao': ngayTao};
  }

  @override
  String toString() {
    return 'PhongBanModel{id: $id, tenPhongBan: $tenPhongBan, ngayTao: $ngayTao}';
  }
}
