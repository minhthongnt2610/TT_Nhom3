import 'package:timetrack/models/trang_thai_nguoi_dung_model.dart';

class NguoiDungModel
{
    final String id;
    final String hoTen;
    final String ma;
    final String email;
    final String chucVu;
    final String phongBanID;
    final String phongBan;
    final String anhDaiDienURL;
    final TrangThaiNguoiDungModel trangThai;
    final DateTime ngayTao;
    final String vaiTro;
    const NguoiDungModel({
        required this.id,
        required this.hoTen,
        required this.ma,
        required this.email,
        required this.chucVu,
        required this.phongBanID,
        required this.phongBan,
        required this.anhDaiDienURL,
        required this.trangThai,
        required this.ngayTao,
        required this.vaiTro,
    });

    NguoiDungModel copyWith({
        String? id,
        String? hoTen,
        String? ma,
        String? email,
        String? chucVu,
        String? phongBanID,
        String? phongBan,
        String? anhDaiDienURL,
        TrangThaiNguoiDungModel? trangThai,
        DateTime? ngayTao,
        String? vaiTro,
    }) 
    {
        return NguoiDungModel(
            id: id ?? this.id,
            hoTen: hoTen ?? this.hoTen,
            ma: ma ?? this.ma,
            email: email ?? this.email,
            chucVu: chucVu ?? this.chucVu,
            phongBanID: phongBanID ?? this.phongBanID,
            phongBan: phongBan ?? this.phongBan,
            anhDaiDienURL: anhDaiDienURL ?? this.anhDaiDienURL,
            trangThai: trangThai ?? this.trangThai,
            ngayTao: ngayTao ?? this.ngayTao,
            vaiTro: vaiTro ?? this.vaiTro,
        );
    }

    Map<String, dynamic> toJson() 
    {
        return 
        {
            'id': id,
            'hoTen': hoTen,
            'ma': ma,
            'email': email,
            'chucVu': chucVu,
            'phongBanID': phongBanID,
            'phongBan': phongBan,
            'anhDaiDienURL': anhDaiDienURL,
            'trangThai': trangThai,
            'ngayTao': ngayTao,
            'vaiTro': vaiTro,
        };
    }

    @override
    String toString() 
    {
        return 'NguoiDungModel{id: $id, hoTen: $hoTen, ma: $ma, email: $email, chucVu: $chucVu, phongBanID: $phongBanID, phongBan: $phongBan, anhDaiDienURL: $anhDaiDienURL, trangThai: $trangThai, ngayTao: $ngayTao, vaiTro: $vaiTro}';
    }

}
