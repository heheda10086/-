SELECT * FROM student WHERE age BETWEEN 20 AND 30;
SELECT *FROM student WHERE age<=30 AND age>=20;
SELECT * FROM student WHERE age=20 OR age=19 OR age=25;
SELECT * FROM student WHERE age IN (20,19,25);
SELECT * FROM student WHERE english IS NOT NULL;#null要用is连接不能用=#
##模糊查询专用like
SELECT * FROM student WHERE NAME LIKE '%德%'; #表示中间含有德字的所有项目
SELECT * FROM student WHERE NAME LIKE '___'; #表示三个字的名字有哪些_用下划线数量来决定
SELECT * FROM student WHERE NAME LIKE '_化%';#下划线确切占用一个字段，表示第二个字叫化的人
#ifnull 查询这个列english，如果不为null 返回english列的值，如果是null就返回0值
SELECT COUNT(IFNULL(english,0)) FROM student;
#分组查询，select 后面要么加聚合函数，要么加分组后的字段，加其他字段没太大意义
#where 用在分组之前的过滤，having一般跟在groupby后用于分组之后的过滤
#where 之后不能跟聚合函数！！！！！！！
SELECT sex,AVG(math),COUNT(id) FROM student WHERE math>70 GROUP BY sex HAVING COUNT(id)>2;
#limit的应用分页限定
SELECT * FROM student LIMIT 0,3;#3表示每页显示3个，0表示每页的第几个
SELECT * FROM student LIMIT 3,3;#limit(当前页码-1）*每页显示条数 页码公式
SELECT * FROM student LIMIT 6,3;

ALTER TABLE emp DROP FOREIGN KEY emp_dep_fk;
ALTER `db3`TABLE emp ADD CONSTRAINT emp_dep_fk FOREIGN KEY (dep_id) REFERENCES dep(id) ON UPDATE CASCADE;
UPDATE emp SET dep_id =NULL WHERE dep_id=1;
UPDATE emp SET dep_id =1 WHERE dep_id IS NULL;
