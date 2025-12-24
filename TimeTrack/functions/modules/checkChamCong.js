const { onCall } = require("firebase-functions/v2/https");
const { db } = require("../firebase");

const checkDistance = require("../util/checkDistance");
const { getToday, getTime } = require("../util/checkDate");
const { getKhuVucChamCong } = require("../service/khuVucChamCong");
const { getThoiGianLamViec } = require("../service/thoiGianLamViec");
const { taoCheckIn, taoCheckOut } = require("../service/chamCongService");
exports.ChamCong = onCall({ region: "us-central1" }, async(request) => {
    //kiểm tra đăng nhập
    if (!request.auth) {
        throw new Error("Bạn chưa đăng nhập");
    }
    const uid = request.auth.uid;
    //lấy tọa độ
    const lat = parseFloat(request.data.lat);
    const lon = parseFloat(request.data.lon);
    if (isNaN(lat) || isNaN(lon)) {
        throw new Error("Tọa độ không hợp lệ");
    }
    //lấy khu vực chấm công
    const khuVuc = await getKhuVucChamCong();
    const distance = checkDistance(
        lat,
        lon,
        khuVuc.toaDo.latitude,
        khuVuc.toaDo.longitude
    );
    const hopLe = distance <= khuVuc.banKinh;
    if (distance > khuVuc.banKinh) {
        return {
            success: false,
            message: "Bạn đang ở ngoài khu vực chấm công",
            distance: Math.round(distance),
            banKinh: khuVuc.banKinh
        };
    }
    //lấy giờ ngày
    const ngay = getToday();
    //ktr đã checkin chưa
    const chamCongSnap = await db
        .collection("ChamCong")
        .where("userId", "==", uid)
        .where("ngay", "==", ngay)
        .limit(1)
        .get();
    if (chamCongSnap.empty) {
        const time = getTime();
        const thoiGianLamViec = await getThoiGianLamViec();
        if (!(thoiGianLamViec.gioBatDau <= time &&
                time <= thoiGianLamViec.gioKetThuc)) {
            return { success: false, message: "Ngoài giờ làm việc, không thể checkin" };
        }
        await taoCheckIn(uid, ngay, hopLe, khuVuc.id, lat, lon);
        return {
            success: true,
            status: "CheckIn",
            hopLe,
            message: hopLe ? "Check-in thành công" : "Bạn đang ngoài khu vực làm việc"
        };
    }
    // nếu chưa thì checkout
    const doc = chamCongSnap.docs[0];
    const data = doc.data();
    if (data.checkOutTime) {
        return {
            success: false,
            message: "Bạn đã hoàn thành chấm công trong ngày",
        };
    }
    await taoCheckOut(doc.ref, lat, lon);
    return {
        success: true,
        status: "CheckOut",
        message: "Check-out thành công",
    };
});