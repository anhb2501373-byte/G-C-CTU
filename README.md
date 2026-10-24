# GÓC CTU

Trang web tiếng Việt dành cho sinh viên CTU, triển khai dạng trang tĩnh.

## Dữ liệu và quyền truy cập

- 28 ảnh trong gói ZIP được đưa vào bucket công khai `goc-ctu-assets` của Supabase. Bucket chỉ cho đọc công khai; quyền tải ảnh nặc danh được mở tạm thời lúc nạp ảnh rồi đóng lại.
- Danh mục địa điểm, cẩm nang và danh mục ảnh được lưu trong Supabase (`places`, `handbook`, `site_assets`) và trang tải nội dung mới nhất khi mở.
- Khu vực quản lý chi tiêu yêu cầu tài khoản email. Giao dịch, ngân sách và mục tiêu tiết kiệm nằm trong Supabase, được giới hạn theo `auth.uid()` bằng RLS. Mỗi người dùng chỉ đọc và sửa dữ liệu của tài khoản mình.
- Nội dung chia sẻ chỉ đọc trên website. Chủ trang cập nhật địa điểm/cẩm nang qua Supabase Studio; website không mở quyền sửa công khai.
- Mã trình duyệt chỉ dùng publishable key. Không đưa service-role/secret key vào trang công khai.

## Xuất bản miễn phí bằng GitHub Pages

1. Tạo repository GitHub công khai tên `G-C-CTU`.
2. Tải toàn bộ nội dung thư mục này lên nhánh `main`.
3. Trong **Settings → Pages**, chọn triển khai từ nhánh `main`, thư mục `/ (root)`.
4. URL dự kiến: `https://anhb2501373-byte.github.io/G-C-CTU/`.
5. Trong Supabase, mở **Authentication → URL Configuration**. Đặt **Site URL** và thêm URL GitHub Pages ở trên vào **Redirect URLs** để email xác nhận tài khoản quay lại đúng trang.

GitHub Pages miễn phí cho repository công khai. Tổ chức Supabase hiện đang dùng gói Free; hạn mức hiện tại gồm 500 MB cơ sở dữ liệu, 1 GB Storage và hạn mức băng thông theo trang giá. Gói Free có thể tự tạm dừng dự án khi gần như không có hoạt động trong 7 ngày. Vì vậy dịch vụ không thể bảo đảm lượng người dùng hoặc lưu lượng không giới hạn miễn phí; theo dõi hạn mức trước khi chia sẻ rộng.

- [GitHub Pages trên GitHub Free](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages)
- [Giá Supabase](https://supabase.com/pricing)
- [Chính sách tạm dừng dự án Free](https://supabase.com/docs/guides/platform/free-project-pausing)

## Supabase

`database/setup.sql` đã được áp dụng cho dự án Supabase GÓC CTU. Tệp tạo bảng danh mục ảnh, seed 11 địa điểm và 9 mục cẩm nang từ gói ZIP, thêm bảng mục tiêu tiết kiệm có RLS và bổ sung ghi chú giao dịch.

Các tệp `database/temporary-upload.sql` và `database/finalize.sql` lưu lại quy trình nạp ảnh. Tệp đầu tiên chỉ dùng trong thời gian tải ảnh; sau khi tải xong phải áp dụng `finalize.sql` để gỡ quyền INSERT nặc danh. Quyền này đã được gỡ khỏi dự án sau khi hoàn tất nạp ảnh.

Để chạy bản sao khác:

1. Áp dụng `database/setup.sql` trong Supabase SQL Editor.
2. Áp dụng `database/temporary-upload.sql` tạm thời; tải tất cả 28 tệp trong `assets/` lên bucket `goc-ctu-assets` với đúng tên tệp.
3. Ngay khi tải xong, áp dụng `database/finalize.sql`.
4. Cập nhật URL/key publishable trong `app-supabase.js` nếu dùng dự án Supabase khác.

## Giới hạn của bản ZIP

Trang giữ phần điều hướng và sơ đồ trong HTML gốc. Các nội dung và ảnh nằm trong gói được đưa vào Supabase; một số ảnh minh họa, biểu tượng, bản đồ nhúng và thư viện CSS/JS của trang gốc vẫn tải từ các địa chỉ bên ngoài. Hãy kiểm tra lại nội dung/ảnh và quyền sử dụng trước khi quảng bá rộng.

