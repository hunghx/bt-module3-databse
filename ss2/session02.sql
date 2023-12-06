# Session 2 - Thiết kế CSDL
# Các Ràng buộc (Constraint) 
-- NOT NULL 
-- UNIQUE
create database session02;
use session02;

create table Person(
-- id int not null unique, 
id int primary key auto_increment, -- id tự tăng và không cần nhập
name varchar(100),
age int ,
sex bit  
); 

-- Thêm dữ liệu vào bảng 
insert into Person(name,age,sex) values
('Nguyễn Văn A',20,1),
('Nguyễn Văn B',22,0)
;
insert into Person(id,name,age,sex) values
(null,'Nguyễn Văn A',20,1); 
# Error Code: 1062. Duplicate entry '1' for key 'person.PRIMARY'


-- lỗi : Error Code: 1062. Duplicate entry '1' for key 'person.id'
-- lỗi : Error Code: 1048. Column 'id' cannot be null
-- lấy dữ liệu của 1 bảng
select * from person;


-- PRIMARY KEY
-- FOREIGN KEY
-- CHECK, DEFAULT


-- CATALOG (1) và PRODUCT(n) 
-- 1 danh mục có mấy sản phẩm (1 -> n)
-- 1 sản phẩm thì thuộc mấy danh muc (1 -> 1)

create table Catalog(
id int primary key auto_increment,
name varchar(100) unique not null,
description text
);

create table Product (
id int auto_increment,
name varchar(100) unique not null,
description text,
price double check (price > 0) ,
stock int,
status bit default 1,
catalog_id int not null,  -- là 1 khóa ngoại tham chiếu tới khóa chính của bảng catalog
constraint fk_01 foreign key(catalog_id) references catalog(id) ,
constraint check_stock check(stock >0),
primary key(id)
);


insert into catalog(name , description) 
values
('áo', ' áo hàng 2nd '),
('quần', '  hàng 2nd '),
('trang sức', '  hàng 2nd ');





insert into product (name, description, price, stock, catalog_id)
values
('Quần jean nữ','không có gì',100,99, 2);
-- Error Code: 3819. Check constraint 'check_stock' is violated.

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`session02`.`product`, CONSTRAINT `fk_01` FOREIGN KEY (`catalog_id`) REFERENCES `catalog` (`id`))


-- thêm / xóa rang buộc
alter table product 
drop constraint fk_01; 

alter table product 
add constraint fk_02 foreign key(catalog_id) references catalog(id);



-- cập nhật danh mục số 3 tên là giày
update catalog set name = 'giày',description = 'nothing'  where id= 3;

-- xóa danh mục có id  = 3
delete from catalog where id = 3;
