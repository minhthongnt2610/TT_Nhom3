function toRadian(deg) {
  return deg * (Math.PI / 180);
}
module.exports = function checkDistance(lat1, lon1, lat2, lon2) {
    const R = 6371000; // bán kính trái đất
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