# 🕒 GPS Time Attendance System (Flutter & Firebase)

Hệ thống chấm công thông minh dựa trên vị trí GPS, được thiết kế cho doanh nghiệp quy mô vừa (3-4 phòng ban). Ứng dụng đảm bảo tính minh bạch bằng cách kết hợp Flutter và kiến trúc Serverless thuần Firebase.

---

## 🚀 Các Vai trò người dùng (Roles)

### 🛡️ Module 0: Authentication (Dùng chung)
- **Đăng nhập/Đăng xuất:** Hệ thống xác thực qua Firebase Auth.
- **Điều hướng thông minh:** Tự động nhận diện Role và chuyển vào Dashboard tương ứng.

### 🧑 Module 1: Nhân viên (Employee)
- **Chấm công GPS:** Check-in/Check-out chỉ khi nằm trong bán kính văn phòng hợp lệ (Geofencing).
- **Quản lý cá nhân:** Xem lịch sử bảng công, số dư ngày phép năm và gửi đơn từ (Nghỉ phép, quên chấm công).

### 👨‍💼 Module 2: Quản lý (Manager)
- **Giám sát phòng ban:** Theo dõi trạng thái làm việc real-time của nhân viên thuộc bộ phận mình phụ trách.
- **Phê duyệt nhanh:** Xử lý các đơn từ nghỉ phép của cấp dưới trực thuộc.

### 👩‍💼 Module 3: Nhân sự (HR) 
- **Quản lý hồ sơ:** Sửa, xóa và cập nhật thông tin nhân viên toàn công ty.
- **Giám sát tổng quát:** Xem lịch sử chấm công và đơn từ của toàn bộ nhân viên không phân biệt phòng ban.
- **Dữ liệu lương:** Xuất báo cáo công tổng hợp phục vụ kỳ tính lương.

### 👑 Module 4: Quản trị viên (Admin)
- **Quản lý hệ thống:** Cấp quyền (Role), định nghĩa phòng ban.
- **Import CSV:** Tải file danh sách nhân viên lên Firebase Storage để tự động khởi tạo tài khoản hàng loạt.
- **Cấu hình Geofence:** Thiết lập tọa độ và bán kính chấm công cho công ty.

---

## 🛠️ Kiến trúc Công nghệ (Tech Stack)

Hệ thống sử dụng giải pháp Native Firebase để đảm bảo tính đồng bộ cao:

- **Frontend:** [Flutter](https://flutter.dev/) (Cross-platform Android/iOS).
- **Xác thực:** [Firebase Authentication](https://firebase.google.com/products/auth).
- **Cơ sở dữ liệu:** [Cloud Firestore](https://firebase.google.com/products/firestore) (Real-time DB).
- **Backend Logic:** [Cloud Functions for Firebase](https://firebase.google.com/products/functions).
  - *HTTPS Trigger:* Xử lý logic Geofencing bảo mật.
  - *Storage Trigger:* Tự động đọc file CSV khi được upload.
- **Lưu trữ tệp:** [Firebase Storage](https://firebase.google.com/products/storage) (Lưu file CSV nhân sự và ảnh hồ sơ).
- **Vị trí & Bản đồ:** [Geolocator](https://pub.dev/packages/geolocator) & [Open Street Map).

---

## 🏗️ Cấu trúc Dữ liệu Firestore



| Collection | Mục đích |
| :--- | :--- |
| `Users` | Lưu UID, Role (Admin/HR/Manager/Employee), `departmentId`. |
| `Departments` | Lưu tên phòng ban và `managerId` chịu trách nhiệm. |
| `TimeLogs` | Lưu chi tiết Check-in/out, tọa độ GPS và trạng thái hợp lệ. |
| `Requests` | Lưu đơn nghỉ phép, trạng thái phê duyệt (`Pending/Approved/Rejected`). |
| `CompanySettings` | Lưu tọa độ văn phòng (Latitude, Longitude) và bán kính Geofence. |

---

## ⚙️ Cơ chế hoạt động (Workflow)

### 📍 Quy trình Geofencing (HTTPS Trigger)
Để ngăn chặn giả mạo vị trí tại Client:
1. Flutter gửi tọa độ hiện tại tới **Cloud Function**.
2. Function tính khoảng cách bằng công thức **Haversine** phía Server.
3. Nếu khoảng cách $\le$ bán kính cho phép, bản ghi `Valid` sẽ được ghi vào Firestore.

### 📂 Quy trình Import CSV (Storage Trigger)
1. **HR/Admin** tải file `nhanvien.csv` lên Firebase Storage.
2. Một Cloud Function `onFinalize` được kích hoạt.
3. Function đọc dữ liệu file, tự động tạo tài khoản trên Firebase Auth và tạo Document người dùng trên Firestore.

---

## 🔧 Thiết lập dự án

1. **Firebase Setup:**
   - Tạo dự án trên Firebase Console.
   - Thêm ứng dụng Android/iOS và tải về tệp cấu hình (`google-services.json` / `GoogleService-Info.plist`).
2. **Backend Deployment:**
   - Cài đặt Firebase CLI: `npm install -g firebase-tools`.
   - Deploy functions: `firebase deploy --only functions`.
3. **Flutter Setup:**
   - Chạy `flutter pub get`.
   - Chạy ứng dụng: `flutter run`.
