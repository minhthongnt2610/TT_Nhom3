import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timetrack/models/firebase/fb_bao_cao_phong_ban_model.dart';

class ExcelService {
  Future<File> exportBaoCaoPhongBan(List<FbBaoCaoPhongBanModel> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['BaoCao'];
    sheet.appendRow([
      TextCellValue('Tên nhân viên'),
      TextCellValue('Mã NV'),
      TextCellValue('Số ngày làm'),
      TextCellValue('Số ngày nghỉ'),
    ]);
    for (var item in data) {
      sheet.appendRow([
        TextCellValue(item.hoTen),
        TextCellValue(item.maNV),
        IntCellValue(item.soNgayLam),
        IntCellValue(item.soNgayNghi),
      ]);
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/bao_cao_cham_cong.xlsx');
    file.writeAsBytesSync(excel.encode()!);
    return file;
  }
}
