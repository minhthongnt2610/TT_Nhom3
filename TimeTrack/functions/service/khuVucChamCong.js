const { db } = require("../firebase");
module.exports.getKhuVucChamCong = async function() {
    const khuVuc = await db.collection("KhuVucChamCong").limit(1).get();

    if (khuVuc.empty) {
        throw new Error("Chưa có khu vực chấm công");
    }

    const doc = khuVuc.docs[0];
    const data = doc.data();

    return {
        id: doc.id,
        tenKhuVuc: data.tenKhuVuc,
        toaDo: data.toaDo,
        banKinh: data.banKinh,
        ngayTao: data.ngayTao,
    };
};