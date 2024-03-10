CREATE database Emp_Dept;

use Emp_Dept;
-- Q1
create table Employee (empno int(10) unique not null,ename varchar(50),job varchar(50) default "Clerk",mgr int(4),hiredate date,sal int(10) check(sal>0),comm int(10),deptno int,foreign key (deptno) references Dept(deptno));

insert into employee values
(7369,"SMITH","CLERK",7902,"1890-12-17",800,null,20),
(7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600,300,30),
(7521,"WARD","SALESMAN",7698,"1981-02-22",1250,500,30),
(7566,"JONES","MANAGER",7839,"1981-04-02",2975,null,20),
(7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250,1400,30),
(7698,"BLAKE","MANAGER",7839,"1981-05-01",2850,null,30),
(7782,"CLARK","MANAGER",7839,"1981-06-09",2450,null,10),
(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000,null,20),
(7839,"KING","PRESIDENT",null,"1981-11-17",5000,null,10),
(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500,0,30),
(7876,"ADAMS","CLERK",7788,"1987-05-23",1100,null,20),
(7900,"JAMES","CLERK",7698,"1981-12-03",950,null,30),
(7902,"FORD","ANALYST",7566,"1981-12-03",3000,null,20),
(7934,"MILLER","CLERK",7782,"1982-01-23",1300,null,10);

select * from employee;

-- Q2
create table Dept(deptno int primary key, dname varchar(50),loc varchar(50)); 

insert into Dept Values 
(10,"OPERATIONS","BOSTON"),
(20,"RESEARCH","DALLAS"),
(30,"SALES","CHICAGO"),
(40,"ACCOUNTING","NEW YORK");

select * from dept;

-- Q3

select ename,sal from employee
where sal>1000;

-- Q4

select * from employee
where hiredate<"1981-09-30";

-- Q5

select ename from employee
where ename like '_I%';

-- Q6

select ename,sal,(0.4*sal) as "Allowances",(0.1*sal) as "P_F",((sal+(0.4*sal))-(0.1*sal)) as "Net_Salary" 
from employee;

-- Q7

select ename,job from employee
where mgr is null;

-- Q8

Select empno,ename,sal
from employee
order by sal asc;

-- Q9

select (count(distinct job))as Jobs_Available from employee;

-- Q10

select sum(sal) as Total_Payable_Salary from employee
where job="SALESMAN";

-- Q11

select * from employee;

SELECT 
    d.dname,
    e.job,
    AVG(e.sal) AS avg_monthly_salary
FROM 
    dept d
JOIN 
    employee e ON d.deptno = e.deptno
GROUP BY 
    d.dname, e.job;

-- Q12

select d.dname,e.ename,e.sal
from employee e
join dept d
on d.deptno=e.deptno;

-- Q13

create table Job_Grades(grade char(1),lowest_sal int,highest_sal int);

insert into Job_Grades values
('A',0,999),
('B',1000,1999),
('C',2000,2999),
('D',3000,3999),
('E',4000,4999);

select * from job_grades;

-- Q14

select ename,sal,
case 
when sal<=999 then 'A'
when sal<=1999 then 'B'
when sal<=2999 then 'C'
when sal<=3999 then 'D'
when sal<=5000 then 'E'
end as Grade
from employee;

-- Q15

select concat(e.ename," Report to ",m.ename) as Reporting
from employee e
join employee m
on e.mgr=m.empno;

-- Q16

select ename,(sal+ifnull(comm,0)) as Total_Sal
from employee;

-- Q17

select empno,ename,sal
from employee
where empno % 2=1;

-- Q18
select * from employee;

SELECT 
    ename,
    RANK() OVER (ORDER BY sal DESC) AS organisation_rank,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS department_rank
FROM 
    employee;

-- Q19

select ename,sal
from employee
order by sal desc
limit 3;

-- Q20
-- this question can be solved using subquery

-- this will be the first part using this we'll know which employee has what dname and salary
select d.dname,e.ename,e.sal
from dept d
join employee e
on d.deptno=e.deptno;

-- using these we can get the max of each dept with deptno but we want ename also .
select ename,deptno,max(sal)
from employee
group by deptno;
	
-- so we will add both queries

select d.dname,e.ename,e.sal
from dept d
join employee e
on d.deptno=e.deptno
where (e.deptno,e.sal) in (
select deptno,max(sal)
from employee
group by deptno
);