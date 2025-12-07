import '../contains/app_icons.dart';

enum TrangThaiDonTuModel{
  daDuyet,
  chuaDuyet,
}
extension TrangThaiNguoiDungExt on TrangThaiDonTuModel {
  String get icon{
    switch(this){
      case TrangThaiDonTuModel.daDuyet:
        return AppIcons.check;
      case TrangThaiDonTuModel.chuaDuyet:
        return AppIcons.unCheck;
    }
  }
}