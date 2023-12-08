# Câu lệnh truy vấn với mệnh đề where
-- hãy lấy ra những người có tuổi > 20 , = 20 , <> 20 , in (20,21,22)
select * from person where age >20;
select * from person where age = 20;
select * from person where age <> 20;
select * from person where age not in (20,21,22);
select * from person where age not between 20 and 22;
-- sử dụng kết hợp các mệnh đề logic 
-- hãy lấy ra người có giới tính là nam và tuổi>21
select * from person where sex = 1 and age >21 ; 
-- hãy lấy nhưng người trong tên có chưa âm 'h'
select * from person where name like '%nguy_n%'; -- '%' đại diện cho 1 hoặc 1 chuỗi kí tự  ,
--  '_' thì chỉ đại diện cho duy nhất 1 kí tự


select * from catalog ;
INSERT INTO `session02`.`product` (`id`, `name`, `description`, `price`, `stock`, `status`, `catalog_id`) VALUES (4, 'đồng hồ unisex', 'cdvfv', 100, 99, 1, null);
INSERT INTO `session02`.`product` (`id`, `name`, `description`, `price`, `stock`, `status`, `catalog_id`) VALUES (2, 'quần  kaki nam', 'cnjfbhhcf', 150, 50, 0, 2);


-- lấy ra tên sản phẩm, mô tả, giá tiền, và tên danh mục 
select *
from product p right join catalog c  on c.id = p.catalog_id
union -- gộp kết quả của 1 hoặc nhiều câu select, chú ý là chỉ gộp được khi kết quả của các câu select có chung số cột
select c.*,p.*
from product p left join catalog c  on c.id = p.catalog_id;

-- join nhiều sử dụng nhiều join + on

-- Câu lệnh truy vấn đầy đủ  
-- 


