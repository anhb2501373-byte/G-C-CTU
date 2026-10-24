-- GÓC CTU website data setup. Safe to apply more than once.
create table if not exists public.site_assets (
  asset_key text primary key, file_name text not null, mime_type text not null,
  size_bytes bigint not null check (size_bytes >= 0), storage_path text not null unique,
  public_url text not null, is_public boolean not null default true,
  updated_at timestamptz not null default now()
);
alter table public.site_assets enable row level security;
grant select on public.site_assets to anon, authenticated;
drop policy if exists "Public can read GOC CTU asset metadata" on public.site_assets;
create policy "Public can read GOC CTU asset metadata" on public.site_assets
  for select to anon, authenticated using (is_public);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('goc-ctu-assets', 'goc-ctu-assets', true, 10485760, array['image/jpeg','image/png','image/svg+xml'])
on conflict (id) do update set public = true, file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;
drop policy if exists "Public can read GOC CTU website images" on storage.objects;
create policy "Public can read GOC CTU website images" on storage.objects
  for select to anon, authenticated using (bucket_id = 'goc-ctu-assets');

insert into public.site_assets (asset_key, file_name, mime_type, size_bytes, storage_path, public_url, is_public)
values
  ('GOC_CTU_ASSET_1f87cb03632f', 'asset_01_1f87cb03632f.svg', 'image/svg+xml', 2022, 'asset_01_1f87cb03632f.svg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_01_1f87cb03632f.svg', true),
  ('GOC_CTU_ASSET_d6014192d6f5', 'asset_02_d6014192d6f5.png', 'image/png', 6484, 'asset_02_d6014192d6f5.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_02_d6014192d6f5.png', true),
  ('GOC_CTU_ASSET_d743272826f1', 'asset_03_d743272826f1.svg', 'image/svg+xml', 2119, 'asset_03_d743272826f1.svg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_03_d743272826f1.svg', true),
  ('GOC_CTU_ASSET_912c6e46390b', 'asset_04_912c6e46390b.jpg', 'image/jpeg', 183753, 'asset_04_912c6e46390b.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_04_912c6e46390b.jpg', true),
  ('GOC_CTU_ASSET_c0de569ecba7', 'asset_05_c0de569ecba7.png', 'image/png', 5889058, 'asset_05_c0de569ecba7.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_05_c0de569ecba7.png', true),
  ('GOC_CTU_ASSET_376ad8e70bea', 'asset_06_376ad8e70bea.png', 'image/png', 737387, 'asset_06_376ad8e70bea.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_06_376ad8e70bea.png', true),
  ('GOC_CTU_ASSET_085b5d480819', 'asset_07_085b5d480819.jpg', 'image/jpeg', 927445, 'asset_07_085b5d480819.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_07_085b5d480819.jpg', true),
  ('GOC_CTU_ASSET_212b673a013d', 'asset_08_212b673a013d.png', 'image/png', 946060, 'asset_08_212b673a013d.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_08_212b673a013d.png', true),
  ('GOC_CTU_ASSET_7b7db70b18ab', 'asset_09_7b7db70b18ab.png', 'image/png', 905299, 'asset_09_7b7db70b18ab.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_09_7b7db70b18ab.png', true),
  ('GOC_CTU_ASSET_f2a0b2620f5c', 'asset_10_f2a0b2620f5c.png', 'image/png', 1039256, 'asset_10_f2a0b2620f5c.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_10_f2a0b2620f5c.png', true),
  ('GOC_CTU_ASSET_5e16331acb39', 'asset_11_5e16331acb39.png', 'image/png', 1273530, 'asset_11_5e16331acb39.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_11_5e16331acb39.png', true),
  ('GOC_CTU_ASSET_a20c2ddbb083', 'asset_12_a20c2ddbb083.jpg', 'image/jpeg', 59774, 'asset_12_a20c2ddbb083.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_12_a20c2ddbb083.jpg', true),
  ('GOC_CTU_ASSET_019a3074cfbc', 'asset_13_019a3074cfbc.jpg', 'image/jpeg', 134972, 'asset_13_019a3074cfbc.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_13_019a3074cfbc.jpg', true),
  ('GOC_CTU_ASSET_3222554c79d9', 'asset_14_3222554c79d9.jpg', 'image/jpeg', 64819, 'asset_14_3222554c79d9.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_14_3222554c79d9.jpg', true),
  ('GOC_CTU_ASSET_2d7e0b81a2b2', 'asset_15_2d7e0b81a2b2.jpg', 'image/jpeg', 141600, 'asset_15_2d7e0b81a2b2.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_15_2d7e0b81a2b2.jpg', true),
  ('GOC_CTU_ASSET_10d7330d04b9', 'asset_16_10d7330d04b9.jpg', 'image/jpeg', 159801, 'asset_16_10d7330d04b9.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_16_10d7330d04b9.jpg', true),
  ('GOC_CTU_ASSET_de4522fe4d37', 'asset_17_de4522fe4d37.jpg', 'image/jpeg', 67359, 'asset_17_de4522fe4d37.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_17_de4522fe4d37.jpg', true),
  ('GOC_CTU_ASSET_a19b5746e0fa', 'asset_18_a19b5746e0fa.jpg', 'image/jpeg', 79853, 'asset_18_a19b5746e0fa.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_18_a19b5746e0fa.jpg', true),
  ('GOC_CTU_ASSET_7bb588f57715', 'asset_19_7bb588f57715.jpg', 'image/jpeg', 71151, 'asset_19_7bb588f57715.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_19_7bb588f57715.jpg', true),
  ('GOC_CTU_ASSET_8611e4d3b8bb', 'asset_20_8611e4d3b8bb.jpg', 'image/jpeg', 96383, 'asset_20_8611e4d3b8bb.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_20_8611e4d3b8bb.jpg', true),
  ('GOC_CTU_ASSET_581dcaf6d65e', 'asset_21_581dcaf6d65e.jpg', 'image/jpeg', 43562, 'asset_21_581dcaf6d65e.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_21_581dcaf6d65e.jpg', true),
  ('GOC_CTU_ASSET_391d13daa575', 'asset_22_391d13daa575.jpg', 'image/jpeg', 98900, 'asset_22_391d13daa575.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_22_391d13daa575.jpg', true),
  ('GOC_CTU_ASSET_62a40465846e', 'asset_23_62a40465846e.jpg', 'image/jpeg', 43419, 'asset_23_62a40465846e.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_23_62a40465846e.jpg', true),
  ('GOC_CTU_ASSET_59ccc5a21aec', 'asset_24_59ccc5a21aec.jpg', 'image/jpeg', 45615, 'asset_24_59ccc5a21aec.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_24_59ccc5a21aec.jpg', true),
  ('GOC_CTU_ASSET_75b4a2b0be33', 'asset_25_75b4a2b0be33.jpg', 'image/jpeg', 276363, 'asset_25_75b4a2b0be33.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_25_75b4a2b0be33.jpg', true),
  ('GOC_CTU_ASSET_571c9c600371', 'asset_26_571c9c600371.jpg', 'image/jpeg', 230993, 'asset_26_571c9c600371.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_26_571c9c600371.jpg', true),
  ('GOC_CTU_ASSET_b89aa94bfb3c', 'asset_27_b89aa94bfb3c.jpg', 'image/jpeg', 140025, 'asset_27_b89aa94bfb3c.jpg', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_27_b89aa94bfb3c.jpg', true),
  ('GOC_CTU_ASSET_315109fb0c10', 'asset_28_315109fb0c10.png', 'image/png', 132753, 'asset_28_315109fb0c10.png', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_28_315109fb0c10.png', true)
on conflict (asset_key) do update set file_name = excluded.file_name, mime_type = excluded.mime_type,
  size_bytes = excluded.size_bytes, storage_path = excluded.storage_path,
  public_url = excluded.public_url, is_public = excluded.is_public, updated_at = now();

grant select on public.places, public.rooms, public.handbook to anon, authenticated;
insert into public.places (id, category, name, price, "priceLabel", phone, address, "distanceKm", description, "imageUrl", tags, "openHours", lat, lng)
values
  ('nha-tro-365-tran-nam-phu', 'Nhà trọ', 'Nhà trọ 365 đường Trần Nam Phú', 3200000, '3.200.000đ/tháng', '09xxxxxxxx', '365 đường Trần Nam Phú, phường Ninh Kiều, thành phố Cần Thơ', 4, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_13_019a3074cfbc.jpg', 'Wi-Fi miễn phí | Sạch sẽ | Mới xây', null, null, null),
  ('hung-vuong', 'Nhà trọ', 'Nhà trọ Hùng Vương', 2200000, '2.200.000đ/tháng', '09xxxxxxxx', 'Đường Hùng Vương, phường Ninh Kiều, thành phố Cần Thơ', 4, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_14_3222554c79d9.jpg', 'Wi-Fi | Máy lạnh | Tự do giờ giấc | 25 m²', null, null, null),
  ('hem-6', 'Nhà trọ', 'Nhà trọ hẻm 6', 800000, '800.000 – 1.000.000đ/tháng', '09xxxxxxxx', 'Hẻm 6, KV 2, phường Hưng Phú, thành phố Cần Thơ', 5, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_15_2d7e0b81a2b2.jpg', 'Wi-Fi tính phí | Giờ giấc tự do | Không ngập nước | Sạch sẽ | 21,6 m²', null, null, null),
  ('nguyen-van-linh', 'Nhà trọ', 'Nhà trọ hẻm Nguyễn Văn Linh', 3000000, '3.000.000đ/tháng', '09xxxxxxxx', 'Đường Nguyễn Văn Linh, thành phố Cần Thơ', 3, 'Tiện nghi khác vui lòng liên hệ chủ trọ để xác nhận.', 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_16_10d7330d04b9.jpg', 'Máy lạnh | Nước nóng | Tủ quần áo | Tối đa 3 người', null, null, null),
  ('nha-tro-sinh-vien-91b', 'Nhà trọ', 'Nhà trọ sinh viên 91B', 2500000, '2.500.000đ/tháng', '09xxxxxxxx', '91B, đường Trần Hoàng Na, phường Ninh Kiều, thành phố Cần Thơ', 4.5, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_17_de4522fe4d37.jpg', 'Tối đa 2 người | Giao thông tốt | Thoáng mát | Wi-Fi miễn phí', null, null, null),
  ('nha-tro-son-lam', 'Nhà trọ', 'Nhà trọ Sơn Lâm', 2600000, '2.600.000đ/tháng', '09xxxxxxxx', 'Đường Mậu Thân, phường Ninh Kiều, thành phố Cần Thơ', 2, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_18_a19b5746e0fa.jpg', 'Tối đa 3 người | Được nuôi thú cưng | Wi-Fi miễn phí | Sạch sẽ', null, null, null),
  ('nha-tro-sinh-vien-439', 'Nhà trọ', 'Nhà trọ sinh viên 439', 1900000, '1.900.000đ/tháng', '09xxxxxxxx', 'Liên tổ 4-5-6, hẻm 51 đường 3 Tháng 2, phường Ninh Kiều, thành phố Cần Thơ', 2, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_19_7bb588f57715.jpg', 'Mới xây | Giá rẻ | Sạch sẽ | Giao thông tốt', null, null, null),
  ('nha-tro-the-he-moi', 'Nhà trọ', 'Nhà trọ thế hệ mới', 4000000, '4.000.000đ/tháng', '09xxxxxxxx', 'Khu Giảng viên, Đại học thành phố Cần Thơ', 3.5, null, 'https://vykvwnrriyeogodbjkzw.supabase.co/storage/v1/object/public/goc-ctu-assets/asset_20_8611e4d3b8bb.jpg', 'Tiện ích đầy đủ | Wi-Fi miễn phí | Có bãi gửi xe | Không ngập', null, null, null),
  ('com-sinh-vien', 'Ăn uống', 'Cơm sinh viên', 15000, '15.000–25.000đ', null, 'Cách cổng A khoảng 300m', 0.3, null, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=300&q=80', 'Giá hợp lý | Nhiều món', null, null, null),
  ('tiem-in-minh-anh', 'Dịch vụ', 'Tiệm in Minh Anh', 2000, null, null, 'Cách cổng A khoảng 700m', 0.7, null, 'https://images.unsplash.com/photo-1581092918056-0c4c3?auto=format&fit=crop&w=300&q=80', 'Nhanh | Tiện lợi', null, null, null),
  ('sua-xe-hung', 'Dịch vụ', 'Sửa xe Hùng', 50000, null, null, 'Cách cổng A khoảng 1,4km', 1.4, null, 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=300&q=80', 'Uy tín | Giá hợp lý', null, null, null)
on conflict (id) do update set category = excluded.category, name = excluded.name, price = excluded.price,
  "priceLabel" = excluded."priceLabel", phone = excluded.phone, address = excluded.address,
  "distanceKm" = excluded."distanceKm", description = excluded.description, "imageUrl" = excluded."imageUrl",
  tags = excluded.tags, "openHours" = excluded."openHours", lat = excluded.lat, lng = excluded.lng;

insert into public.handbook (id, category, title, summary, content, url)
values
  ('dang-ky-tam-tru', 'Thủ tục hành chính', 'Đăng ký tạm trú', 'Các bước cần chuẩn bị và nơi liên hệ.', 'Các bước cần chuẩn bị và nơi liên hệ.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('lam-the-sinh-vien', 'Thủ tục hành chính', 'Làm thẻ sinh viên', 'Thông tin hồ sơ và quy trình cấp thẻ.', 'Thông tin hồ sơ và quy trình cấp thẻ.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('quy-trinh-vay-von-sinh-vien', 'Thủ tục hành chính', 'Quy trình vay vốn sinh viên', 'Tổng quan giấy tờ và kênh tư vấn chính thức.', 'Tổng quan giấy tờ và kênh tư vấn chính thức.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('dang-ky-hoc-phan', 'Học thuật', 'Đăng ký học phần', 'Chuẩn bị kế hoạch học tập và kiểm tra lịch đăng ký.', 'Chuẩn bị kế hoạch học tập và kiểm tra lịch đăng ký.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('cach-tinh-diem-he-so-4', 'Học thuật', 'Cách tính điểm hệ số 4', 'Khái quát cách quy đổi điểm học phần và GPA.', 'Khái quát cách quy đổi điểm học phần và GPA.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('lich-thi-va-quy-che', 'Học thuật', 'Lịch thi và quy chế', 'Luôn đối chiếu thông báo mới nhất của trường.', 'Luôn đối chiếu thông báo mới nhất của trường.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('checklist-tuan-dau-tai-ctu', 'Hoạt động sinh viên', 'Checklist tuần đầu tại CTU', 'Kiểm tra tài khoản sinh viên, lịch học, thẻ sinh viên, email trường và các kênh thông báo chính thức.', 'Kiểm tra tài khoản sinh viên, lịch học, thẻ sinh viên, email trường và các kênh thông báo chính thức.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('cac-cau-lac-bo-tai-ctu', 'Hoạt động sinh viên', 'Các câu lạc bộ tại CTU', 'Khám phá hoạt động và cộng đồng sinh viên.', 'Khám phá hoạt động và cộng đồng sinh viên.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/'),
  ('diem-ren-luyen', 'Hoạt động sinh viên', 'Điểm rèn luyện', 'Theo dõi hoạt động, minh chứng và thời hạn.', 'Theo dõi hoạt động, minh chứng và thời hạn.

Thông tin tham khảo từ bản website được cung cấp. Hãy kiểm tra hướng dẫn mới nhất trên các kênh chính thức của Đại học Cần Thơ trước khi thực hiện.', 'https://www.ctu.edu.vn/')
on conflict (id) do update set category = excluded.category, title = excluded.title,
  summary = excluded.summary, content = excluded.content, url = excluded.url;

alter table public.transactions add column if not exists notes text;
grant select, insert, update, delete on public.transactions, public.budgets to authenticated;
create table if not exists public.finance_goals (
  id text primary key, user_id uuid not null references auth.users(id) on delete cascade,
  name text not null, target numeric not null check (target > 0),
  saved numeric not null default 0 check (saved >= 0 and saved <= target),
  created_at timestamptz not null default now()
);
alter table public.finance_goals enable row level security;
grant select, insert, update, delete on public.finance_goals to authenticated;
create index if not exists finance_goals_user_id_idx on public.finance_goals (user_id);
drop policy if exists "Users read own finance goals" on public.finance_goals;
drop policy if exists "Users insert own finance goals" on public.finance_goals;
drop policy if exists "Users update own finance goals" on public.finance_goals;
drop policy if exists "Users delete own finance goals" on public.finance_goals;
create policy "Users read own finance goals" on public.finance_goals
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users insert own finance goals" on public.finance_goals
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users update own finance goals" on public.finance_goals
  for update to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
create policy "Users delete own finance goals" on public.finance_goals
  for delete to authenticated using ((select auth.uid()) = user_id);
revoke execute on function public.handle_new_gocctu_user() from public, anon, authenticated;
