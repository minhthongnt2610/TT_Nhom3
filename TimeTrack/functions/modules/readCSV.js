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

    // 1. Tải file CSV từ Storage về local
    await bucket.file(filePath).download({ destination: tempPath });
    const csvText = fs.readFileSync(tempPath, "utf8");
    // 2. Parse CSV
    const records = parse(csvText, {
      columns: true,
      skip_empty_lines: true,
      trim: true,
    });

    const auth = getAuth();
    const db = getFirestore();

    let created = 0;
    let updated = 0;
    const errors = [];

    // 3. Xử lý từng dòng CSV
    for (let i = 0; i < records.length; i++) {
      const row = records[i];

      try {
        const ma = (row.ma || "").trim();
        const hoTen = (row.hoTen || "").trim();
        const vaiTro = (row.vaiTro || "").trim(); // admin / hr / quanly / nhanvien
        const phongBan = (row.phongBan || "").trim();
        const phongBanID = (row.phongBanID || "").trim();
        const anhDaiDienURL = (row.anhDaiDienURL || "").trim();

        if (!ma) throw new Error(`Missing 'ma' at row ${i + 1}`);
        if (!vaiTro) throw new Error(`Missing 'vaiTro' at row ${i + 1}`);

        // 🔥 Email và mật khẩu theo yêu cầu
        const email = `${ma.toLowerCase()}@mailinator.com`;
        const password = `${ma}12345@`;

        let userRecord;
        let isNew = false;

        // 3.1 Kiểm tra user đã tồn tại chưa
        try {
          userRecord = await auth.getUserByEmail(email);
        } catch (error) {
          if (error.code === "auth/user-not-found") {
            // 3.2 Tạo user mới
            userRecord = await auth.createUser({
              email,
              password,
              displayName: hoTen,
            });
            isNew = true;
          } else {
            throw error;
          }
        }

        const uid = userRecord.uid;

        // 🔥 GÁN CUSTOM CLAIMS THEO CSV
        await auth.setCustomUserClaims(uid, { role: vaiTro });

        // 🔥 Lưu thông tin vào Firestore
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

        if (isNew) created++;
        else updated++;

      } catch (err) {
        console.error(`Error on row ${i + 1}:`, err);
        errors.push({ row: i + 1, error: err.message });
      }
    }

    console.log("Done:", { created, updated, errors });

    // 4. Move file sang processed/
    const newPath = filePath.replace("imports/", "processed/");
    await bucket.file(filePath).move(newPath);

    fs.unlinkSync(tempPath);
  }
);
