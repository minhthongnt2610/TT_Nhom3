const { onRequest } = require("firebase-functions/v2/https");
const { initializeApp } = require("firebase-admin/app");
const { getAuth } = require("firebase-admin/auth");
const { getFirestore, Timestamp } = require("firebase-admin/firestore");
initializeApp();
// Hàm tạo tài khoản admin.
exports.createAdminAccount = onRequest(
  { region: "us-central1" },
  async (req, res) => {
    const auth = getAuth();
    const db = getFirestore();
    const email = "admin@mailinator.com";
    const password = "Admin12345@";
    try {
      let  userDetail;
      // Kiểm tra xem email này đã tồn tại hay chưa.
      try {
         userDetail = await auth.getUserByEmail(email);
        console.log("Tài khoản đã tồn tại với UID:",  userDetail.uid);
      } catch (error) {
        // Nếu chưa tồn tại thì tạo mới.
        if (error.code === "auth/user-not-found") {
           userDetail = await auth.createUser({
            email: email,
            password: password,
          });
          console.log("Đã tạo tài khoản admin mới, UID:",  userDetail.uid);
        } else {
          throw error;
        }
      }
      const uid =  userDetail.uid;
      // Gán quyền admin bằng custom claims
      await auth.setCustomUserClaims(uid, { role: "admin" });
      // Lưu thêm thông tin vào Firestore
      await db.collection("NguoiDung").doc(uid).set(
        {
          id: uid,
          hoTen: "Administrator",
          email: email,
          ma: "ADMIN001",
          chucVu: "Admin",
          phongBan: "Admin department",
          phongBanID: "admin-dept",
          anhDaiDienURL: "",
          vaiTro: "admin",
          trangThai: 1,
          ngayTao: Timestamp.now(),
        },
        { merge: true }
      );
      res.json({
        success: true,
        uid: uid,
        message: "Tài khoản admin đã được tạo hoặc đã tồn tại.",
      });
    } catch (error) {
      console.error("Lỗi khi tạo admin:", error);
      res.status(500).json({
        success: false,
        error: error.message,
      });
    }
  }
);
