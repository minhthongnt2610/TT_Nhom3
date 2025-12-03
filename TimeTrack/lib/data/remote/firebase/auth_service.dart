import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
    AuthService()
    {
        log('AuthService created');
    }
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? get currentUser => _firebaseAuth.currentUser;
    bool isUserLogin()
    {
        return currentUser != null;
    }

    Future<String?> logInAndGetRole({
      required String email,
      required String password,
    }) async {
      try {
        print("===== BẮT ĐẦU ĐĂNG NHẬP =====");

        // 1. Đăng nhập Firebase Auth
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);

        User user = userCredential.user!;

        // LOG user info
        print(">>> EMAIL: ${user.email}");
        print(">>> UID: ${user.uid}");
        // 2. Lấy custom claims (refresh token để lấy mới nhất)
        IdTokenResult tokenResult = await user.getIdTokenResult(true);

        print(">>> TOKEN CLAIMS: ${tokenResult.claims}");

        final claims = tokenResult.claims;

        if (claims == null) {
          print(">>> claims == null → không có custom claims");
          return null;
        }

        // 3. Lấy role từ claims
        String? role = claims["role"] as String?;
        print(">>> ROLE: $role");

        // 4. Kiểm tra role hợp lệ
        if (role == "admin" ||
            role == "nhanvien" ||
            role == "hr" ||
            role == "quanly") {
          print(">>> ROLE HỢP LỆ, TRẢ VỀ: $role");
          return role;
        }

        print(">>> ROLE KHÔNG HỢP LỆ HOẶC CHƯA ĐƯỢC SET");
        return null;

      } catch (e) {
        print(">>> LỖI ĐĂNG NHẬP: $e");
        rethrow;
      }
    }

}
