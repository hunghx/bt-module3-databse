--  đo tốc đột truy vấn
  -- chưa có index 
 explain analyze select * from users where name like "Maxie Thiel";
 -- -> Filter: (users.`name` like 'Maxie Thiel')  (cost=103 rows=111) (actual time=1.34..1.45 rows=1 loops=1)
 --  (cost=103 rows=998) (actual time=0.0893..1.29 rows=998 loops=1)
 
 -- tạo index 
 create index index_name
 on users(name);
 -- -> Index range scan on users using index_name over (name = 'Maxie Thiel'), with index condition: (users.`name` like 'Maxie Thiel')  
 -- (cost=0.71 rows=1) (actual time=0.138..0.144 rows=1 loops=1)
 