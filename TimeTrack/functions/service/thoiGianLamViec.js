const { db } = require("../firebase");
module.exports.getThoiGianLamViec = async function() {
    const thoiGian = await db.collection("ThoiGianLamViec").get();
    if (thoiGian.empty) {
        throw new Error("Chưa có thời gian làm việc");
    }
    const doc = thoiGian.docs[0];
    const t = doc.data();
    return {
        id: doc.id,
        tenCa: t.tenCa,
        gioBatDau: t.gioBatDau,
        gioKetThuc: t.gioKetThuc
    };
}