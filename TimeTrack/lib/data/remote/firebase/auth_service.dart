import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //biến static này cho toàn class
  static final AuthService _instance = AuthService._internal();

  // hàm khởi tạo công khai
  // khi khởi tạo AuthService thì sẽ không tạo instance mới mà gọi lại instance đã tạo trước đó
  factory AuthService() {
    return _instance;
  }

  // hàm khởi tạo private, khi instance được tạo thì sẽ ghi log
  AuthService._internal() {
    log("khởi tạo AuthService");
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  bool isUserLogin() {
    return currentUser != null;
  }

  Future<String?> logInAndGetRole({
    required String email,
    required String password,
  }) async {
    try {
      print("BẮT ĐẦU ĐĂNG NHẬP");
      // Đăng nhập bằng email và pass, userCredential để cho biết user đã đng nhập là ai.
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      //lấy thông tin user
      User user = userCredential.user!;
      print("EMAIL: ${user.email}");
      print("UID: ${user.uid}");
      //yêu cầu firebase refesh lại token mới để nhận claim mới nhất
      IdTokenResult tokenResult = await user.getIdTokenResult(true);
      print("TOKEN CLAIMS: ${tokenResult.claims}");
      // kiểm tra custom claims
      final claims = tokenResult.claims;
      if (claims == null) {
        print("claims == null → không có custom claims");
        return null;
      }
      // lấy role từ claims.
      String? role = claims["role"] as String?;
      print("ROLE: $role");
      //Kiểm tra role hợp lệ.
      if (role == "admin" ||
          role == "nhanvien" ||
          role == "hr" ||
          role == "quanly") {
        print("ROLE HỢP LỆ, TRẢ VỀ: $role");
        return role;
      }
      print("ROLE KHÔNG HỢP LỆ HOẶC CHƯA ĐƯỢC SET");
      return null;
    } catch (e) {
      print("LỖI ĐĂNG NHẬP: $e");
      rethrow;
    }
  }
}
