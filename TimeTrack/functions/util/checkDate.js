module.exports.getToday = function() {
    const today = new Date();
    const timeVietNam = new Date(today.getTime() + 7 * 60 * 60 * 1000);
    const d = String(timeVietNam.getUTCDate()).padStart(2, '0');
    const m = String(timeVietNam.getUTCMonth() + 1).padStart(2, '0');
    const y = timeVietNam.getUTCFullYear();
    return `${y}-${m}-${d}`;
}

module.exports.getTime = function() {
    const time = new Date();
    const timeVN = new Date(time.getTime() + 7 * 60 * 60 * 1000);
    const h = String(timeVN.getUTCHours()).padStart(2, '0');
    const m = String(timeVN.getUTCMinutes()).padStart(2, '0');
    return `${h}:${m}`;
}