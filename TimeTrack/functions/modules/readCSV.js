const { onObjectFinalized } = require("firebase-functions/v2/storage");
const { initializeApp } = require("firebase-admin/app");
const { getAuth } = require("firebase-admin/auth");
const { getFirestore, Timestamp } = require("firebase-admin/firestore");
const { getStorage } = require("firebase-admin/storage");
const { parse } = require("csv-parse/sync");
const fs = require("fs");
const os = require("os");
const path = require("path");
initializeApp();
exports.createUsersFromCsv = onObjectFinalized(
  {
    region: "us-central1",
    bucket: "timetrack-264b6.firebasestorage.app"
  },
  async (event) => {
    const filePath = event.data.name;
    // Chỉ xử lý file trong thư mục imports/
    if (!filePath.startsWith("imports/")) {
      console.log("Skip file:", filePath);
      return;
    }
    console.log("Processing CSV:", filePath);
    const bucket = getStorage().bucket();
    const tempPath = path.join(os.tmpdir(), "file.csv");
    // Tải file CSV từ Storage về local.
    await bucket.file(filePath).download({ destination: tempPath });
    // Đọc nội dung file csv dưới dạng text.
    const csvText = fs.readFileSync(tempPath, "utf8").replace(/^\uFEFF/, "");
    // chuyển file csv thành mảng đối tượng
    const fileCSV = parse(csvText, {
      columns: true,
      bom: true,
      skip_empty_lines: true,
      trim: true,
    });
    const auth = getAuth();
    const db = getFirestore();
    const errors = [];
    //Xử lý từng dòng trong file CSV
    for (let i = 0; i < fileCSV.length; i++) {
      const row = fileCSV[i];
      try {
        const ma = (row.ma || "").trim();
        const hoTen = (row.hoTen || "").trim();
        const vaiTro = (row.vaiTro || "").trim();
        const phongBan = (row.phongBan || "").trim();
        const phongBanID = (row.phongBanID || "").trim();
        const anhDaiDienURL = (row.anhDaiDienURL || "").trim();

        if (!ma) throw new Error(`Lỗi 'ma' tại dòng ${i + 1}`);
        if (!vaiTro) throw new Error(`Lỗi 'vaiTro' tại dòng ${i + 1}`);
        const email = `${ma.toLowerCase()}@mailinator.com`;
        const password = `${ma}12345@`;
        let accountUser;
        try {
          accountUser = await auth.getUserByEmail(email);
        } catch (error) {
          if (error.code === "auth/user-not-found") {
            accountUser = await auth.createUser({
              email,
              password,
              displayName: hoTen,
            });
          } else {
            throw error;
          }
        }
        const uid = accountUser.uid;
        await auth.setCustomUserClaims(uid, { role: vaiTro });
        await db.collection("NguoiDung").doc(uid).set(
          {
            id: uid,
            hoTen,
            email,
            ma,
            vaiTro,
            phongBan,
            phongBanID,
            anhDaiDienURL,
            trangThai: 1,
            ngayTao: Timestamp.now(),
          },
          { merge: true }
        );

      } catch (err) {
        console.error(`Lỗi tại dòng ${i + 1}:`, err);
        errors.push({ row: i + 1, error: err.message });
      }
    }
    console.log("Kết quả lỗi:", errors);
    const newPath = filePath.replace("imports/", "processed/");
    await bucket.file(filePath).move(newPath);

    fs.unlinkSync(tempPath);
  }
);
