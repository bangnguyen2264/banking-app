🏦 Banking App

Ứng dụng ngân hàng trực tuyến được xây dựng bằng Spring Boot (Backend) và Flutter (Frontend). Hỗ trợ đăng nhập, quản lý tài khoản, giao dịch và bảo mật bằng JWT.

🚀 Tính năng chính

🔐 Xác thực và phân quyền người dùng (JWT)

📊 Quản lý tài khoản ngân hàng (Số dư, lịch sử giao dịch)

💳 Chuyển khoản, gửi tiết kiệm, rút tiền

📈 API RESTful với bảo mật cao

📑 Document API với OpenAPI (Swagger)

📱 Ứng dụng Flutter với giao diện thân thiện, hiệu suất cao

🛠 Công nghệ sử dụng

🔙 Backend

Ngôn ngữ: Java, Spring Boot

Bảo mật: Spring Security, JWT

Database: PostgreSQL

Container: Docker, Docker Compose

API Docs: SpringDoc OpenAPI

📱 Frontend

Ngôn ngữ: Dart, Flutter

Quản lý trạng thái: Provider 

Giao tiếp Backend: Http (REST API)

Xác thực:  SharedPreferences, FlutterSecureStorage

📦 Cài đặt và chạy dự án
1️⃣  Chạy Backend bằng Docker Compose

docker-compose up --build

2️⃣ Cài đặt và chạy Frontend (Flutter)
CHạy lệnh git: git clone https://github.com/bangnguyen2264/banking-app.git

Yêu cầu:

Flutter SDK (>=3.3.1 <4.0.0)

Android Studio / VS Code (để chạy trên Android)

Xcode (để chạy trên iOS)

Cài đặt dependencies:

cd banking-app
flutter pub get

Chạy ứng dụng trên thiết bị giả lập hoặc thật:
