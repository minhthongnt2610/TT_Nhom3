class BaoCaoTongHopModel {
  final String id;
  final String hoTen;
  final String maNV;
  final int soNgayLam;
  final int soNgayNghi;
  final String phongBan;

  const BaoCaoTongHopModel({
    required this.id,
    required this.hoTen,
    required this.maNV,
    required this.soNgayLam,
    required this.soNgayNghi,
    required this.phongBan,
  });

  BaoCaoTongHopModel copyWith({
    String? id,
    String? hoTen,
    String? maNV,
    int? soNgayLam,
    int? soNgayNghi,
    String? phongBan,
  }) {
    return BaoCaoTongHopModel(
      id: id ?? this.id,
      hoTen: hoTen ?? this.hoTen,
      maNV: maNV ?? this.maNV,
      soNgayLam: soNgayLam ?? this.soNgayLam,
      soNgayNghi: soNgayNghi ?? this.soNgayNghi,
      phongBan: phongBan ?? this.phongBan,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hoTen': hoTen,
      'maNV': maNV,
      'soNgayLam': soNgayLam,
      'soNgayNghi': soNgayNghi,
      'phongBan': phongBan,
    };
  }

  @override
  String toString() {
    return 'BaoCaoTongHopModel{id: $id, hoTen: $hoTen, maNV: $maNV, soNgayLam: $soNgayLam, soNgayNghi: $soNgayNghi}';
  }
}
