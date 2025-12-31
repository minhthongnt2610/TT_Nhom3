const { onCall } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.taoDonTu = onCall({ region: "us-central1" }, async (request) => {
  if (!request.auth) {
    throw new Error("Bạn chưa đăng nhập");
  }
  const uid = request.auth.uid;
  const { loaiDon, lyDo, tuNgay, denNgay } = request.data;
  if (!loaiDon || !lyDo || !tuNgay || !denNgay) {
    throw new Error("Thiếu dữ liệu tạo đơn");
  }
  const userSnap = await db.collection("NguoiDung").doc(uid).get();
  if (!userSnap.exists) {
    throw new Error("Không tìm thấy nhân viên");
  }
  const user = userSnap.data();
  const quanLySnap = await db
    .collection("NguoiDung")
    .where("phongBanID", "==", user.phongBanID)
    .where("vaiTro", "==", "quanly")
    .limit(1)
    .get();
  const idQuanLy = quanLySnap.docs[0].id; // Lấy ID của quản lý
  await db.collection("DonTu").add({
    userId: uid,
    hoTen: user.hoTen,
    maNV: user.ma,
    phongBanID: user.phongBanID,
    quanLyID: idQuanLy,
    loaiDon,
    lyDo,
    tuNgay,
    denNgay,
    trangThai: "cho_duyet",
    ngayTao: admin.firestore.Timestamp.now(),
  });

  return { success: true, message: "Gửi đơn thành công" };
});
