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

Các ảnh không được lưu trong GitHub vì website đọc ảnh từ bucket Supabase. Một số ảnh minh họa, bản đồ nhúng, biểu tượng và thư viện giao diện trong HTML gốc vẫn tải từ các địa chỉ bên ngoài.

## Gói miễn phí

GitHub Pages và Supabase Free không tính phí khi dùng trong hạn mức hiện hành. Supabase có giới hạn dung lượng và lưu lượng; dự án Free có thể tự tạm dừng sau thời gian dài ít hoạt động. Vì thế không có lượng người dùng/lưu lượng không giới hạn được bảo đảm miễn phí.

- [GitHub Pages trên GitHub Free](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages)
- [Giá Supabase](https://supabase.com/pricing)
- [Chính sách tạm dừng dự án Supabase Free](https://supabase.com/docs/guides/platform/free-project-pausing)

## Giới hạn nội dung

Trang giữ cấu trúc và sơ đồ trong HTML gốc. Một số bản đồ nhúng, ảnh minh họa và thư viện giao diện vẫn đến từ dịch vụ bên ngoài. Hãy kiểm tra quyền sử dụng các nội dung đó trước khi quảng bá rộng.
