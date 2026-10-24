-- Danh sách 186 phòng do chủ website cung cấp.
-- Chạy sau setup.sql khi cần nạp lại danh sách; khóa roomCode giúp chạy lặp an toàn.
-- Script chỉ cập nhật thông tin phòng/nhà xe, không ghi đè roomMapUrl hay campusMapUrl.
WITH ranges(building_code, building_name, first_no, last_no, floor, parking) AS (
  VALUES
    ('C2','Nhà học C2',101,111,1,'Nhà xe C2'),
    ('C2','Nhà học C2',201,211,2,'Nhà xe C2'),
    ('C2','Nhà học C2',301,310,3,'Nhà xe C2'),
    ('DB','Khoa Dự bị Dân tộc',101,104,1,'Nhà xe Dự bị dân tộc'),
    ('DB','Khoa Dự bị Dân tộc',201,204,2,'Nhà xe Dự bị dân tộc'),
    ('DB','Khoa Dự bị Dân tộc',301,304,3,'Nhà xe Dự bị dân tộc'),
    ('KL','Khoa Luật',101,102,1,'Nhà xe Khoa Luật'),
    ('MT','Khoa Khoa học Chính trị',102,103,1,'Nhà xe Trường Kinh tế'),
    ('MT','Khoa Khoa học Chính trị',201,203,2,'Nhà xe Trường Kinh tế'),
    ('MT','Khoa Khoa học Chính trị',301,303,3,'Nhà xe Trường Kinh tế'),
    ('DI','Trường Công nghệ Thông tin và Truyền thông',101,111,1,'Nhà xe Trường CNTT'),
    ('DI','Trường Công nghệ Thông tin và Truyền thông',201,221,2,'Nhà xe Trường CNTT'),
    ('NN','Trường Nông nghiệp',8,14,1,'Nhà xe NN'),
    ('NN','Trường Nông nghiệp',106,112,2,'Nhà xe NN'),
    ('XH','Khoa Khoa học Xã hội và Nhân văn',101,115,1,'Nhà xe XH'),
    ('XH','Khoa Khoa học Xã hội và Nhân văn',210,219,2,'Nhà xe XH'),
    ('XH','Khoa Khoa học Xã hội và Nhân văn',301,316,3,'Nhà xe XH'),
    ('ATL','Nhà ATL',101,115,1,'Nhà xe ATL'),
    ('ATL','Nhà ATL',201,215,2,'Nhà xe ATL'),
    ('ATL','Nhà ATL',301,315,3,'Nhà xe ATL')
), room_rows AS (
  SELECT
    r.building_code || '-' || lpad(n.room_no::text, 3, '0') AS "roomCode",
    r.building_name AS building,
    lpad(n.room_no::text, 3, '0') AS "roomNumber",
    r.floor,
    r.parking
  FROM ranges r
  CROSS JOIN LATERAL generate_series(r.first_no, r.last_no) AS n(room_no)
)
INSERT INTO public.rooms ("roomCode", building, "roomNumber", floor, parking)
SELECT "roomCode", building, "roomNumber", floor, parking
FROM room_rows
ON CONFLICT ("roomCode") DO UPDATE SET
  building = EXCLUDED.building,
  "roomNumber" = EXCLUDED."roomNumber",
  floor = EXCLUDED.floor,
  parking = EXCLUDED.parking;

