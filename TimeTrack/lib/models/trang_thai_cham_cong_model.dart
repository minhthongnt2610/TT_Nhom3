import 'dart:core';

enum TrangThaiChamCongModel { daChamCong, chuaChamCong }

extension TrangThaiChamCongext on TrangThaiChamCongModel {
  get int {
    switch (this) {
      case TrangThaiChamCongModel.daChamCong:
        return 1;
      case TrangThaiChamCongModel.chuaChamCong:
        return 0;
    }
  }
}
