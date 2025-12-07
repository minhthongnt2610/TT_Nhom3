import 'package:flutter/material.dart';


enum TrangThaiNguoiDungModel{
  daChamCong,
  chuaChamCong,
}
extension TrangThaiNguoiDungExt on TrangThaiNguoiDungModel {
  Color get color{
    switch(this){
      case TrangThaiNguoiDungModel.daChamCong:
         return Colors.green;
      case TrangThaiNguoiDungModel.chuaChamCong:
         return Colors.grey;
    }
  }
}