1#查询所有员工信息.员工编号，员工姓名，工资，职务名称，职务描述
SELECT emp.id,emp.ename,salary,jname,description FROM emp LEFT JOIN 
job ON job.`id`=emp.`job_id` ; 

#2查询员工编号，员工姓名，工资，职务名称，职务描述，部门名称，部门位置
SELECT emp.id,emp.ename,salary,jname,description,dname,loc FROM emp 
 LEFT JOIN 
 job ON job.`id`=emp.`job_id`
 LEFT JOIN 
 dept ON dept.`id`=emp.`dept_id`;
#3查询员工姓名，工资，工资等级
SELECT t1.ename,salary,grade FROM emp t1, salarygrade t2
WHERE t1.salary BETWEEN losalary AND hisalary

#select t1.`salary`,grade from emp t1, salarygrade t2
#where t1.salary between losalary and hisalary
#4 查询员工姓名，工资，职务名称，职务描述，部门名称，部门位置，工资等级
SELECT t1.ename,t1.salary,t3.jname,t3.description,t2.dname,t2.loc,t4.grade
FROM 
	emp t1, dept t2,job t3,salarygrade t4
WHERE 
	t1.salary BETWEEN losalary AND hisalary
	AND t3.id=t1.`job_id` 
	AND t2.id=t1.`dept_id`;
#5 查询出部门编号，部门名称，部门位置，部门人数
SELECT t1.dept_id,t2.dname,t2.loc,COUNT(t1.dept_id) '人数'
FROM 
	emp t1 , dept t2 
WHERE t1.`dept_id`=t2.`id` 
GROUP BY t1.dept_id
ORDER BY '人数';
#6查询所有员工的姓名及其直接上级的名字，没有领导的员工也要查询
SELECT t1.ename, t2.ename 
FROM emp t1 LEFT JOIN emp t2
ON t1.mgr=t2.id;