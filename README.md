# GÓC CTU

Website tiếng Việt dành cho sinh viên CTU, được cung cấp dưới dạng trang tĩnh.

## Dịch vụ đang dùng

- GitHub Pages phục vụ trang web công khai từ kho `anhb2501373-byte/G-C-CTU`.
- Supabase lưu dữ liệu địa điểm, cẩm nang, danh mục ảnh và dữ liệu chi tiêu cá nhân.
- 28 ảnh của website đã được đưa vào bucket công khai `goc-ctu-assets` trên Supabase. Ảnh chỉ cho đọc công khai; quyền tải nặc danh được gỡ sau khi nạp xong.
- Tài khoản email bảo vệ khu vực chi tiêu. Giao dịch, ngân sách và mục tiêu tiết kiệm được giới hạn theo người dùng bằng RLS.
- Website không cấp quyền cho khách truy cập sửa danh mục dùng chung. Trình duyệt chỉ chứa publishable key, không có khóa quản trị.

## Bật GitHub Pages

1. Vào **Settings → Pages** của kho này.
2. Chọn **Deploy from a branch**, nhánh `main`, thư mục `/ (root)`, rồi lưu.
3. Trang sẽ có địa chỉ `https://anhb2501373-byte.github.io/G-C-CTU/`.
4. Trong Supabase, mở **Authentication → URL Configuration**. Đặt URL ở trên làm **Site URL** và thêm nó vào **Redirect URLs** để xác nhận email quay lại đúng trang.

## Supabase

`database/setup.sql` ghi lại cấu trúc dữ liệu và quyền truy cập đã thiết lập cho website; tệp này đã được áp dụng cho dự án Supabase GÓC CTU. Dữ liệu ban đầu gồm 11 địa điểm và 9 mục cẩm nang. `database/finalize.sql` gỡ chính sách tải ảnh tạm thời; chính sách này đã được gỡ khỏi dự án sau khi nạp ảnh.

## Thêm sơ đồ dãy nhà

1. Tải ảnh PNG/JPG lên **Storage → `goc-ctu-assets`** và sao chép URL công khai.
2. Mở **Table Editor → `rooms`**. Với sơ đồ chung của một dãy, thêm dòng có `roomCode` là mã dãy (ví dụ `KL`) và dán URL vào `roomMapUrl`.
3. Với sơ đồ theo tầng, thêm một dòng mỗi tầng. Ví dụ tầng 1 dãy ATL dùng `roomCode = ATL-F1`, `building = Nhà ATL`, `floor = 1`, cùng URL ảnh trong `roomMapUrl`.

Website nhận các mã dãy hiện có như KL, C2, ATL và DI. Tìm riêng mã dãy sẽ hiện sơ đồ; tìm mã phòng như `ATL-301` hoặc `DI-101` sẽ chọn sơ đồ tầng tương ứng. Nếu dãy mới chưa có trong danh sách mã của website, cần cập nhật website thêm một lần.

## Danh sách phòng và nhà xe

Bảng `rooms` hiện có thêm 186 phòng. Danh sách được lưu trong `database/room_directory.sql`. Khi bổ sung phòng, thêm một dòng cho mỗi phòng: `roomCode = C2-101`, `roomNumber = 101`, `floor = 1`, `parking = Nhà xe C2`. Giữ số phòng dạng chữ để bảo toàn số 0 đầu như `008`. Không ghi đè các dòng sơ đồ hiện có; để `roomMapUrl` trống ở dòng chỉ mô tả phòng.

Các ảnh không được lưu trong GitHub vì website đọc ảnh từ bucket Supabase. Một số ảnh minh họa, bản đồ nhúng, biểu tượng và thư viện giao diện trong HTML gốc vẫn tải từ các địa chỉ bên ngoài.

## Gói miễn phí

GitHub Pages và Supabase Free không tính phí khi dùng trong hạn mức hiện hành. Supabase có giới hạn dung lượng và lưu lượng; dự án Free có thể tự tạm dừng sau thời gian dài ít hoạt động. Vì thế không có lượng người dùng/lưu lượng không giới hạn được bảo đảm miễn phí.

- [GitHub Pages trên GitHub Free](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages)
- [Giá Supabase](https://supabase.com/pricing)
- [Chính sách tạm dừng dự án Supabase Free](https://supabase.com/docs/guides/platform/free-project-pausing)

## Giới hạn nội dung

Trang giữ cấu trúc và sơ đồ trong HTML gốc. Một số bản đồ nhúng, ảnh minh họa và thư viện giao diện vẫn đến từ dịch vụ bên ngoài. Hãy kiểm tra quyền sử dụng các nội dung đó trước khi quảng bá rộng.

