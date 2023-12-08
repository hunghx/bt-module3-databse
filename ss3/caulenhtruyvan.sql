# truy vấn đầy đủ 
use quanLydiemthi;
-- Hãy lấy ra danh sách học sinh bao gồm , tên sinh viên, mã sinh viên, tuổi, giới tính(nam/ nữ) , số điện thoại , sắp xếp theo tuổi giảm dần
-- B1 xác định số bảng tham gia : 1 bảng 
-- xác đinh các trương thông tin : 5 cột
select studentName `tên sinh viên`
,studentId `mã sinh viên` 
,year(curdate()) - year(birthday) `tuổi` 
,if(gender=1,'Nam','Nữ') `Giới tính` 
,phoneNumber `Số điện thoai`
from student
order by `tuổi` desc, `tên sinh viên` desc;

-- hãy đếm số lượng nam nữ trong danh sách sinh viên

-- b1 : nhóm các sinh viên theo giới tính 
select if(gender=1,'Nam','Nữ') `Giới tính`, count(studentId) `Số lượng`
from student
group by gender;

-- select count(*) from student;
-- lấy ra điêm thi trung bình của từng học sinh  (tên học sinh, mã hoc sinh, điểm trung bình) + điểm trung bình > 7.5

-- bảng student , mark
select s.studentName,s.studentId, avg(m.point) from student s join mark m 
on s.studentId = m.studentId
group by s.studentId
having avg(m.point)>7.5
order by avg(m.point) desc;

-- hãy xếp loại học lực của sinh viên theo điểm trung bình
select s.studentName `Họ Tên`,s.studentId `Mã sinh viên`, avg(m.point) `Điểm trung bình`,
	case 
		when avg(m.point) < 6.5 then 'Yếu'
		when avg(m.point) < 7 then 'Trung bình'
        when avg(m.point) < 8 then 'khá'
        when avg(m.point) < 9 then 'Giỏi'
        else 'Xuất sắc'
	end 
    `Xếp loại`
from student s join mark m 
on s.studentId = m.studentId
group by s.studentId
order by `Điểm trung bình` desc;


