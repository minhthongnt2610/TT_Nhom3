import 'package:cloud_functions/cloud_functions.dart';

class FunctionService {
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(
    region: 'us-central1',
  );

  Future<Map<String, dynamic>> chamCong({
    required double lat,
    required double lon,
  }) async {
    try {
      final callable = _functions.httpsCallable('ChamCong');
      final result = await callable.call({'lat': lat, 'lon': lon});
      return Map<String, dynamic>.from(result.data);
    } on FirebaseFunctionsException catch (e) {
      return {'success': false, 'message': e.message, 'code': e.code};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> taoDonTu({
    required String loaiDon,
    required String lyDo,
    required String tuNgay,
    required String denNgay,
  }) async {
    try {
      final callable = _functions.httpsCallable('taoDonTu');
      final result = await callable.call({
        'loaiDon': loaiDon,
        'lyDo': lyDo,
        'tuNgay': tuNgay,
        'denNgay': denNgay,
      });

      return Map<String, dynamic>.from(result.data);
    } on FirebaseFunctionsException catch (e) {
      return {'success': false, 'message': e.message};
    }
  }
}
