-- lấy ra mã học sinh , tên học sinh, môn thi và điểm thi của học sinh theo môn học
-- tạo view 

create view VIEW_MARK
as
select s.studentId,s.studentName,sb.subjectName,m.point from student s join mark m on s.studentId = m.studentId
join subject sb on sb.subjectId = m.subjectId;


-- view là 1 bảng , thực hiện ruy vấn như bảng thông thường
select * from view_mark;

-- xóa view 
drop view view_mark;


-- tạo chỉ mục cho cột tên sinh viên
create index index_studentName
on student(studentName); 

create index index_studentName_address
on student(studentName,phoneNumber); 

-- cấp phát vùng nhớ 
-- tạo thủ tục
delimiter //
create procedure insert_student(id_new varchar(4)
, name_new varchar(100)
,birthday_new date, gen_new bit, address_new text, phone_new varchar(45))
begin
	insert into student values(id_new,name_new,birthday_new,gen_new,address_new, phone_new);
end;
//

-- gọi thủ tục 
call insert_student('S097','Hồ XUân Hùng 3','2013-10-10',1,'Hà Nội','09959845653'); 
-- Error Code: 1644. Bạn học sinh này chưa đủ tuổi đi học


-- tạo thủ tục tính điểm trung bình và xếp loại học lực của học sinh theo mã học sinh và trả về giá trị đó
 
delimiter //
create procedure cal_student_avg(stu_id varchar(4), OUT dtb double, out hoc_luc varchar(50))
begin 
-- declare avg_point double;
-- stuid = "S001"
	select avg(point) into dtb from mark m where m.studentId = stu_id;
    
    set hoc_luc = 
    case 
		when dtb<6.5 then'yếu'
		when dtb<7 then 'trung bình'
		when dtb<8 then 'khá'
		when dtb <9 then 'giỏi'
		else 'xuất sắc'
	end;
end;

delimiter // -- cấp phát vùng nhớ
create procedure insert_student(id_new varchar(4), name_new varchar(100),birthday_new date, gen_new bit, address_new text, phone_new varchar(45))
begin

    insert into student values(id_new,name_new,birthday_new,gen_new,address_new, phone_new);
end;//

create trigger before_insert_into_student
    before insert on student
    for each row
-- thực thi khối code
begin
    if year(curdate())-year(new.birthday)<13 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bạn học sinh này chưa đủ tuổi đi học';
    end if;
end;


create trigger after_insert_into_student
    after insert on student
    for each row
-- thực thi khối code
begin
    --  thực hiện tăng số lượng sinh viên lên 1 đơn vị
end;


-- cập nhât

-- cập nhật tuổi của học sinh và kiểm tra nếu như tuổi cập nhật mà <14 thì không cho cập nhạt

create trigger before_update_student
    before update on student
    for each row
begin
    if year(curdate())-year(new.birthday)<13 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bạn học sinh này chưa đủ tuổi đi học';
    end if;
end;

-- nếu address null/ "" /dộ dài <4 ki tự thì giữa nguyên giá trị cũ
create trigger before_update_student_1
    before update on student
    for each row
begin
    declare address_current text;
    select address into address_current from student where studentId = NEW.studentId;
    if new.address is null or NEW.address = '' or length(NEW.address)<4
        then set NEW.address =  address_current;
        end if;
end;


update student set address = 'Nghệ An' where studentId = 'S001';

select  year('2010-10-10')

-- tạo trigger 
-- hãy tạo thủ tục thêm mới kiểm tra xem học sinh đã đủ 14 tuổi hay chưa trước khi thêm vào bảng

drop trigger before_insert_into_student;
create trigger before_insert_into_student
    before insert on student
    for each row
-- thực thi khối code
begin
    if year(curdate())-year(new.birthday)<13 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bạn học sinh này chưa đủ tuổi đi học';
    end if;
end;



-- gọi procedure
call cal_student_avg('S001',@dtb,@hocluc);

select @dtb,@hocluc;


-- ràng buộc, ngày tạo không thể lớn hơn ngày hiện tại

create table product (
id int primary key auto_increment,
created_date date check (created_date <= curdate())
);
