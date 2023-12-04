# Tạo CSDL - tạo 1 lần cho 1 ứng dụng 
# drop database if exists democsdl;
creaTe dataBase if not exists deMocSdl ;
# chọn csdl : click đúp chuột vào tên CSDL bên bảng sidebar
use democsdl;

# tạo bảng 
create table if not exists Catalogs(
	# định nghĩa các trường
    # long, int, short, byte, double, float , boolean   là kiểu số -> SQL bigint,int,smallint,tinyint,double,float, bit
    # String , char là chuỗi -> SQL text, blob(ko mặc định giới hạn kí tự và tối đa 65***) , varchar( bắt buộc giới hạn, 65***) , char(max = 255)
   # Date -> SQL datetime , time, date
   id bigint ,
   name varchar(100),
   description text ,
   status bit
);
# xóa bảng
# drop table if exists Catalogs;
# định nghĩa lại bảng 
# thêm cột
-- alter table Catalogs 
-- add column imageUrl text ;
# xóa
-- alter table Catalogs
-- drop column imageUrl;
# định nghĩa lại
-- alter table Catalogs
-- modify column imageUrl varchar(255);


