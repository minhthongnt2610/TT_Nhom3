const { db } = require("../firebase");
const { Timestamp, GeoPoint } = require("firebase-admin/firestore");
module.exports.taoCheckIn = async function(uid, ngay, hopLe, khuvucId, lat, lon) {
    return await db.collection("ChamCong").add({
        userId: uid,
        ngay: ngay,
        trangThai: hopLe ? "HopLe" : "NgoaiKhuVuc",
        khuVucId: khuvucId,
        checkInTime: Timestamp.now(),
        checkInLocation: new GeoPoint(lat, lon),
        checkOutTime: null,
        checkOutLocation: null
    });
};
module.exports.taoCheckOut = async function(ChamCongId, lat, lon) {
    return await ChamCongId.update({
        checkOutTime: Timestamp.now(),
        checkOutLocation: new GeoPoint(lat, lon)
    });
};