const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

// Khởi tạo Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Nhập UID của user muốn set admin
const uid = "V81BL1VhsQS8uSUWeuUQNfNnoSh1";  // ← THAY BẰNG UID THẬT

async function setAdmin() {
  try {
    await admin.auth().setCustomUserClaims(uid, { role: "admin" });
    console.log(`✔ User ${uid} đã được set role admin`);
    process.exit(0);
  } catch (error) {
    console.error("❌ Lỗi:", error);
    process.exit(1);
  }
}

setAdmin();
