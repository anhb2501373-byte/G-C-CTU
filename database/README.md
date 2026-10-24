# Cài đặt Supabase

`setup.sql` ghi lại các bảng, chính sách truy cập và dữ liệu khởi tạo cho website. Website hiện dùng dự án Supabase GÓC CTU đã được cấu hình sẵn. `finalize.sql` gỡ quyền tải ảnh tạm thời; đã áp dụng sau khi nạp đủ ảnh.

Ảnh đang nằm trong bucket công khai `goc-ctu-assets`. Website chỉ đọc ảnh công khai. Khu vực chi tiêu yêu cầu đăng nhập; giao dịch, ngân sách và mục tiêu tiết kiệm bị giới hạn theo tài khoản đăng nhập bằng RLS.

Không chạy tệp SQL trên một dự án khác nếu chưa rà soát cấu hình và nạp ảnh vào bucket đó. Mã trình duyệt sử dụng publishable key; không đưa khóa quản trị vào trang web.

## Thêm sơ đồ

Tải ảnh lên bucket `goc-ctu-assets`, sau đó thêm dòng vào `public.rooms`. Dùng `roomCode` bằng mã dãy cho một sơ đồ chung (ví dụ `KL`). Với nhiều tầng, dùng mã dạng `ATL-F1`, đặt `building` là `Nhà ATL`, `floor` là số tầng và `roomMapUrl` là URL ảnh công khai. Website sẽ chọn sơ đồ tầng theo mã phòng tìm kiếm.

## Thêm danh sách phòng học

Mỗi phòng là một dòng riêng trong `public.rooms`: ví dụ `roomCode = C2-101`, `roomNumber = 101`, `floor = 1`, `parking = Nhà xe C2`. Cột `roomNumber` là text, nên giữ số 0 đầu cho mã như `008`. Không thay thế các dòng dùng làm sơ đồ dãy/tầng; để `roomMapUrl` trống trên dòng chỉ lưu thông tin phòng.

Danh sách đã nạp cho website được ghi lại trong `room_directory.sql`. Có thể chạy tệp này sau `setup.sql` khi cần nạp lại; các dòng trùng `roomCode` chỉ cập nhật thông tin phòng và nhà xe, không ghi đè URL sơ đồ.

