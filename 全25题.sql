#1. 查询“01”课程比“02”课程成绩高的所有学生的学号；增加题目内容，学生的学号和名字
SELECT DISTINCT t1.sid AS sid,sname 
FROM
(SELECT DISTINCT t1.sid FROM
  (SELECT* FROM sc WHERE cid="01")t1 LEFT JOIN 
  (SELECT* FROM sc WHERE cid="02")t2
ON t1.sid=t2.sid WHERE t1.score>t2.score)t1 
 LEFT JOIN student ON t1.sid=student.sid
 GROUP BY sid,sname
 #2. 查询平均成绩大于60分的同学的学号和平均成绩
 SELECT DISTINCT sid,AVG(score)AS avg_score
 FROM sc
 GROUP BY sid HAVING AVG(score)>60
 
 #2.2增加题目内容 加入姓名，
 SELECT DISTINCT sc.sid,sname,AVG(score)AS avg_score
 FROM sc
  RIGHT JOIN
 student ON student.sid=sc.sid GROUP BY sid HAVING AVG(score)>60#group by 要放到最后
 #3. 查询所有同学的学号、姓名、选课数、总成绩
 SELECT student.sid,sname,COUNT(cid)AS cnt_course, SUM(score) AS sum_score
 FROM student LEFT JOIN sc ON student.sid=sc.sid GROUP BY sid 
 #4. 查询姓“李”的老师的个数；
 SELECT COUNT(tid)
 FROM teacher WHERE tname LIKE ("李%");#这里出错用了=号不是通配符like
#5 5. 查询没学过“张三”老师课的同学的学号、姓名；
SELECT 
  sid,
  sname 
FROM
  student 
WHERE sid NOT IN 
  (SELECT 
    sid 
  FROM
    teacher 
    LEFT JOIN course #原本要加sc。sid因为本题这个是唯一的不
      ON teacher.tid = course.tid 
    LEFT JOIN sc 
      ON course.cid = sc.cid 
  WHERE tname = "张三");

#6 查询学过“01”并且也学过编号“02”课程的同学的学号、姓名；

SELECT t1.sid AS sid,sname FROM( SELECT t1.sid FROM

(SELECT sid FROM sc WHERE cid="01") t1 JOIN
(SELECT sid FROM sc WHERE cid="02") t2 ON t1.sid = t2.sid

)t1 LEFT JOIN student ON student.sid=t1.sid;

#7. 查询学过“张三”老师所教的课的同学的学号、姓名；
SELECT 
  student.sid AS sid,
  sname 
FROM
  (SELECT 
    cid 
  FROM
    course 
    LEFT JOIN teacher 
      ON teacher.tid = course.tid 
  WHERE teacher.tname = "张三") course 
  LEFT JOIN sc 
    ON course.cid = sc.cid 
  LEFT JOIN student 
    ON sc.sid = student.sid ;
#8 查询课程编号“01”的成绩比课程编号“02”课程低的所有同学的学号、姓名；
SELECT t1.sid AS sid ,sname FROM
   (SELECT t1.sid FROM
 (SELECT sid,score FROM sc WHERE cid="01")t1 LEFT JOIN
 (SELECT sid,score FROM sc WHERE cid="02")t2 ON
 t1.sid=t2.sid WHERE t1.score<t2.score)t1 LEFT JOIN 
 student ON t1.sid=student.sid;
 #9查询所有课程成绩小于60分的同学的学号、姓名；
SELECT t1.sid AS sid,sname FROM 

(SELECT sc.sid,MAX(score) FROM sc GROUP BY sc.sid HAVING MAX(score<60))t1 
LEFT JOIN student ON student.sid=t1.sid ; 
#10 查询没有学全所有课的同学的学号、姓名
SELECT t1.sid,sname FROM(

SELECT sc.sid,COUNT(cid) FROM sc GROUP BY sc.sid HAVING COUNT(cid)
<(SELECT DISTINCT COUNT(cid) FROM course))t1  LEFT JOIN student ON student.sid=t1.sid;
#11 查询至少有一门课与学号为“01”的同学所学相同的同学的学号和姓名；
SELECT DISTINCT sc.sid,sname FROM 

(SELECT cid
        FROM sc
        WHERE sid='01')t1 LEFT JOIN sc ON sc.cid=t1.cid
        LEFT JOIN student ON student.sid=sc.sid;
        
#12. 查询和"01"号的同学学习的课程完全相同的其他同学的学号和姓名
SELECT
    t1.sid,sname
FROM
    (
        SELECT
            sc.sid
            ,COUNT(DISTINCT sc.cid)
        FROM 
            (
                SELECT
                    cid
                FROM sc
                WHERE sid='01'
            )t1 #选出01的同学所学的课程
        LEFT JOIN sc
            ON t1.cid=sc.cid
        GROUP BY sc.sid# 因为有有很多组去重会影响结果显示，用group by来进行分组
        HAVING COUNT(DISTINCT sc.cid)= (SELECT COUNT(DISTINCT cid) FROM sc WHERE sid = '01')
    )t1
LEFT JOIN student
    ON t1.sid=student.sid
WHERE t1.sid!='01';#！=就是不等于的意思直接去掉重复项目01

  # 14查询没学过"张三"老师讲授的任一门课程的学生姓名
  SELECT sid AS sid,sname FROM student WHERE sid
  
  NOT IN (
  SELECT sid FROM sc LEFT JOIN course ON sc.cid=course.cid LEFT JOIN
  teacher ON teacher.tid=course.tid WHERE tname="张三");
 #15  查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩 
 SELECT t1.sid,sname,AVG(kkk) AS sdfaf  FROM (
 
  SELECT sc.sid,COUNT(IF(score<60,cid,NULL)),AVG(score)AS kkk FROM sc GROUP BY
  sid HAVING COUNT(IF(score<60,cid,NULL))>=2)t1 
  LEFT JOIN 
  student ON student.sid=t1.sid ; 
 #16检索"01"课程分数小于60，按分数降序排列的学生信息
 SELECT sid, 
 
   IF(cid="01",score,NULL)AS "分数小于六十分"FROM sc WHERE IF(cid='01',score,NULL)<60
   ORDER BY "分数小于六十分" DESC;
 #17 按平均成绩从高到低显示所有学生的平均成绩
 SELECT  AVG(score) AS avg_score,sid FROM sc GROUP BY sid ORDER BY avg_score DESC;
 
 #18 查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，
 #最高分，最低分，平均分，及格率
 
SELECT 
  sc.cid,
  cname,
  MAX(score) AS highest_score,
  MIN(score) AS lowest_score,
  AVG(score) AS avg_score,
  COUNT(IF(score >= 60, sid, NULL)) / COUNT(sid) AS pass_rate 
FROM
  sc 
  LEFT JOIN course 
    ON course.cid = sc.cid 
GROUP BY sc.cid ;
#19按各科平均成绩从低到高和及格率的百分数从高到低顺序
SELECT 
  sc.cid,
  cname,
  AVG(score) AS avg_score,
  COUNT(IF(score >= 60, sid, NULL))/COUNT(sid) AS pass_rate 
FROM
  sc 
  LEFT JOIN course 
    ON course.cid = sc.cid 
GROUP BY cid
ORDER BY avg_score,
  pass_rate DESC 
 #20查询学生的总成绩并进行排名
 SELECT sname,sc.sid,SUM(score) AS sum_score
 FROM sc RIGHT JOIN student ON student.sid=sc.`sid`
 GROUP BY sname ORDER BY sum_score DESC
 #21查询不同老师所教不同课程平均分从高到低显示(这里的tname）因为没有出现过不需要加前缀只默认一个
SELECT 
  tname,teacher.tid,
  AVG(score) AS avg_score 
FROM
  sc 
  LEFT JOIN course 
    ON course.cid = sc.cid 
  LEFT JOIN teacher 
    ON course.tid = teacher.tid 
GROUP BY course.tid 
ORDER BY avg_score DESC ;
#22 查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
SELECT 
#23. 统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
 SELECT sc.cid,cname,COUNT(IF(score BETWEEN 85 AND 100,sid,NULL))/COUNT(sid),
 COUNT(IF(score BETWEEN 70 AND 85,sid,NULL))/COUNT(sid),
 COUNT(IF(score BETWEEN 60 AND 70,sid,NULL))/COUNT(sid),
 COUNT(IF(score BETWEEN 0 AND 60,sid,NULL))/COUNT(sid)
 FROM sc LEFT JOIN course ON course.cid=sc.cid GROUP BY sc.cid;
#26. 查询每门课程被选修的学生数
 SELECT cname,COUNT(sid),sc.cid
 
 FROM sc LEFT JOIN course ON course.cid=sc.cid GROUP BY cid;
#27. 查询出只选修了一门课程的全部学生的学号和姓名
 SELECT sc.sid,sname, COUNT(cid) AS count_course
 
 FROM sc LEFT JOIN student ON student.sid=sc.sid GROUP BY sc.sid 
 HAVING COUNT(cid)=2;
#28. 查询男生、女生人数\
SELECT
    ssex
    ,COUNT( sid)FROM student GROUP BY ssex;
 #29  查询名字中含有"风"字的学生信息
 SELECT sid,sname FROM student WHERE sname LIKE "%风%" 
#30 查询同名同性学生名单，并统计同名人数
 
SELECT
    ssex
    ,sname
    ,COUNT(sid)
FROM student
GROUP BY sname,ssex
HAVING COUNT(sid)>=2;
#31 查询1990年出生的学生名单(注：Student表中Sage列的类型是datetime)
SELECT sid,sname,sage FROM student WHERE YEAR(sage)=1990;
#32 查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
SELECT sc.cid,cname, AVG(score) AS avg_score FROM sc LEFT JOIN course ON sc.cid=course.cid 
GROUP BY cid ORDER BY avg_score ,cid DESC;

# 33 查询不及格的课程，并按课程号从大到小排列(查询的是课程）
SELECT cid, score AS unpass_score FROM sc WHERE score<60 ORDER BY  cid DESC
#34 查询课程编号为"01"且课程成绩在60分以上的学生的学号和姓名；
SELECT sc.sid,sname, score FROM sc LEFT JOIN student ON student.sid=sc.sid WHERE score>60 
AND cid="01";
#区别和第九题的区别，第九题是去“所有”课都不及格，课与课之间是有类比的，所以增加了
#聚合函数的用法，先对课程之间进行筛选，
#35 查询选修“张三”老师所授课程的学生中，成绩最高的学生姓名及其成绩

SELECT 
  sc.sid,
  sname,
  score 
FROM
  sc 
  LEFT JOIN course 
    ON sc.cid = course.cid 
  LEFT JOIN teacher 
    ON teacher.tid = course.tid 
  LEFT JOIN student 
    ON student.sid = sc.sid 
WHERE tname = "张三" 
ORDER BY score DESC 
LIMIT 1 ;
#36 
#37 统计每门课程的学生选修人数（超过5人的课程才统计）。要求输出课程号和选修人数
#，查询结果按人数降序排列，若人数相同，按课程号升序排列
SELECT cid, COUNT(sid) FROM sc 
GROUP BY cid HAVING COUNT(sid)>=5 ORDER BY COUNT(sid) DESC,cid;
#38 检索至少选修两门课程的学生学号
SELECT sid,COUNT(cid) FROM sc GROUP BY sid HAVING COUNT(cid)>=2 
#39. 查询选修了全部课程的学生信息
SELECT sc.sid,sname,COUNT(cid) FROM sc LEFT JOIN student ON student.sid=sc.sid GROUP BY sc.sid
HAVING COUNT(cid)=(SELECT COUNT(DISTINCT cid) FROM sc)
#40 查询各学生的年龄
SELECT sid,sname, YEAR(CURDATE())-YEAR(sage) AS age
FROM student;
#41 查询本周过生日的学生
SELECT
    sid,sname,sage
FROM student
WHERE WEEKOFYEAR(sage)=WEEKOFYEAR(CURDATE())
#42. 查询下周过生日的学生
SELECT sid,sname,sage FROM student
WHERE WEEKOFYEAR(sage)=WEEKOFYEAR(DATE_ADD(CURDATE(),INTERVAL 1 MONTH));
#43. 查询本月过生日的学生
SELECT sid,sname,sage FROM student
WHERE MONTH(sage)=MONTH(CURDATE());
#44. 查询下个月月过生日的学生
SELECT sid,sname,sage FROM student
WHERE MONTH(CURDATE())=MONTH(DATE_ADD(sage,INTERVAL 1 MONTH));
SELECT sid,sname,sage FROM student
WHERE MONTH(DATE_SUB(sage,INTERVAL 2 MONTH)) = MONTH(CURDATE());
##测试点就是date_add 和date_sub