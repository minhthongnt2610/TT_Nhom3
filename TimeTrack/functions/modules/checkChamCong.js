const { onCall } = require("firebase-functions/v2/https");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore, Timestamp } = require("firebase-admin/firestore");
const { getAuth } = require("firebase-admin/auth");

initializeApp();

const db = getFirestore();
const auth = getAuth();

function toRadian(de) {
    return de * Math.PI / 180;
}

function checkDistance(lat1, lon1, lat2, lon2) {
    const R = 6371e3; // bán kính trái đất
    const dlat = toRadian(lat2 - lat1); // tính hiệu của vĩ độ
    const dlon = toRadian(lon2 - lon1); //kinh độ
    // công thức haversine
    const a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
        Math.cos(toRadian(lat1)) * Math.cos(toRadian(lat2)) *
        Math.sin(dlon / 2) * Math.sin(dlon / 2);
    // tính khoảng cách
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)); // tính góc giữa 2 điểm
    const d = R * c;
    return d;
}

function getToday() {
    const today = new Date();
    const timeVietNam = new Date(today.getTime() + 7 * 60 * 60 * 1000);
    const d = String(timeVietNam.getUTCDate()).padStart(2, '0');
    const m = String(timeVietNam.getUTCMonth() + 1).padStart(2, '0');
    const y = timeVietNam.getUTCFullYear();
    return `${y}-${m}-${d}`;

}
exports.checkChamCong = onCall({ region: "us-central1" }, async(request) => {
    const x = request;
    const data = request.data;
    // xac thuc nguoi dung
    if (!x.auth) {
        throw new Error("Bạn phải đăng nhập để sử dụng chức năng này");
    };
    const uid = x.auth.uid;
    //lay toa do tu nguoi dung
    const userLat = data.lat;
    const userLon = data.lon;

});