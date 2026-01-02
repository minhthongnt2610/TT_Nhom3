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
      // Đăng nhập bằng email và pass, userCredential để cho biết user đã đng nhập là ai.
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      //lấy thông tin user
      User user = userCredential.user!;
      //yêu cầu firebase refesh lại token mới để nhận claim mới nhất
      IdTokenResult tokenResult = await user.getIdTokenResult(true);
      // kiểm tra custom claims
      final claims = tokenResult.claims;
      if (claims == null) {
        print("claims == null → không có custom claims");
        return null;
      }
      // lấy role từ claims.
      String? role = claims["role"] as String?;
      print("role: $role");
      //Kiểm tra role hợp lệ.
      if (role == "admin" ||
          role == "nhanvien" ||
          role == "hr" ||
          role == "quanly") {
        return role;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAdmin() async {
    final user = currentUser;
    if (user == null) {
      return false;
    }
    final token = await user.getIdTokenResult(true);
    final role = token.claims?["role"];
    return role == "admin";
  }

  Future<bool> checkNV() async {
    final user = currentUser;
    if (user == null) {
      return false;
    }
    final token = await user.getIdTokenResult(true);
    final role = token.claims?["role"];
    return role == "nv";
  }

  Future<bool> checkHr() async {
    final user = currentUser;
    if (user == null) {
      return false;
    }
    final token = await user.getIdTokenResult(true);
    final role = token.claims?["role"];
    return role == "hr";
  }

  Future<bool> checkQuanLy() async {
    final user = currentUser;
    if (user == null) {
      return false;
    }
    final token = await user.getIdTokenResult(true);
    final role = token.claims?["role"];
    return role == "quanly";
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final user = currentUser;
    if (user == null) {
      throw Exception("Không tìm thấy người dùng hiện tại");
    }
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}
