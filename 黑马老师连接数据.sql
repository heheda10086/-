CREATE TABLE dept(
id INT PRIMARY KEY PRIMARY KEY,
dname VARCHAR(50),
loc VARCHAR(50)
);
-- 添加四个部门`test2`
INSERT INTO dept(id,dname,loc)VALUES
(10,'教研部','北京'),
(20,'学工部','上海'),
(30,'销售部','广州'),
(40,'财务部','深圳');

CREATE TABLE job(
id INT PRIMARY KEY,
jname VARCHAR(20),
description VARCHAR(50)
);

INSERT INTO job (id,jname,description ) VALUES
(1,'董事长','管理整个公司'),
(2,'经理','管理部门员工'),
(3,'销售员','先客人推销产品'),
(4,'文员','使用办公软件');

-- 员工表
CREATE TABLE emp(
id INT PRIMARY KEY,
ename VARCHAR(50),
job_id INT ,
mgr INT, joindate DATE,
salary DECIMAL(7,2),
bonus DECIMAL(7,2),
dept_id INT,
CONSTRAINT emp_jobid_ref_job_id_fk FOREIGN KEY (job_id) REFERENCES job(id),
CONSTRAINT emp_deptid_ref_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept(id)
);

INSERT INTO emp(id, ename, job_id,mgr,joindate, salary,bonus,dept_id) VALUES
(1001,'',4,1004,'2000-12-17','8000.00',NULL,20),
(1002,'',3,1006,'2001-02-20','16000.00','3000.00',30),
(1003,'',3,1006,'2001-02-22','12500.00','5000.00',30),
(1004,'',2,1009,'2001-04-02','29750.00',NULL,20),
(1005,'',4,1006,'2001-09-28','12500.00','14000.00',30),
(1006,'',2,1009,'2001-05-01','28500.00',NULL,30),
(1007,'',2,1009,'2001-09-01','24500.00',NULL,10),
(1008,'',4,1004,'2007-04-19','30000.00',NULL,20),
(1009,'',1,NULL,'2001-11-17','50000.00',NULL,10),
(1010,'',3,1006,'2001-09-08','15000.00','0.00',30),
(1011,'',4,1004,'2007-05-23','11000.00',NULL,20),
(1012,'',4,1006,'2001-12-03','9500.00',NULL,30),
(1013,'',4,1004,'2001-12-03','30000.00',NULL,20),
(1014,'',4,1007,'2002-01-23','13000.00',NULL,10);

CREATE TABLE salarygrade(
grade INT PRIMARY KEY,
losalary INT,
hisalary INT
);

INSERT INTO salarygrade(grade,losalary,hisalary) VALUES
(1,7000,120000),
(2,12010,14000),
(3,14010,20000),
(4,20010,30000),
(5,30010,99990);
