class BaoCaoChamCongModel {
  final String id;
  final String hoTen;
  final String maNV;
  final int soNgayLam;
  final int soNgayNghi;

  const BaoCaoChamCongModel({
    required this.id,
    required this.hoTen,
    required this.maNV,
    required this.soNgayLam,
    required this.soNgayNghi,
  });

  BaoCaoChamCongModel copyWith({
    String? id,
    String? hoTen,
    String? maNV,
    int? soNgayLam,
    int? soNgayNghi,
  }) {
    return BaoCaoChamCongModel(
      id: id ?? this.id,
      hoTen: hoTen ?? this.hoTen,
      maNV: maNV ?? this.maNV,
      soNgayLam: soNgayLam ?? this.soNgayLam,
      soNgayNghi: soNgayNghi ?? this.soNgayNghi,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hoTen': hoTen,
      'maNV': maNV,
      'soNgayLam': soNgayLam,
      'soNgayNghi': soNgayNghi,
    };
  }

  @override
  String toString() {
    return 'BaoCaoChamCongModel{id: $id, hoTen: $hoTen, maNV: $maNV, soNgayLam: $soNgayLam, soNgayNghi: $soNgayNghi}';
  }
}
