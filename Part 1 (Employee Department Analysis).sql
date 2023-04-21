create database newproject;
use newproject;


#Q1 CREATE TABLE DEPT


create table dept (
deptno int primary key,
dname varchar(100),
loc varchar(100));

insert into dept values(10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');

Select * from dept;



#Q2 CREATE TABLE EMPLOYEE

create table employee (
empno int unique not null ,
ename varchar(100),
job VARCHAR(50) DEFAULT 'Clerk',
mgr int,
hiredate date,
Salary DECIMAL(10,2) CHECK (Salary >= 0),
comm float,
deptno int,
foreign key (deptno) references dept (deptno));
  
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7369,'SMITH','CLERK',7902,'1890-12-17',800.00,20);
insert into employee (empno,ename,job,mgr,hiredate,Salary,comm,deptno) values (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,comm,deptno) values (7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,20);
insert into employee (empno,ename,job,mgr,hiredate,Salary,comm,deptno) values (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,10);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,20);
insert into employee (empno,ename,job,hiredate,Salary,deptno) values (7839,'KING','PRESIDENT','1981-11-17',5000.00,10);
insert into employee (empno,ename,job,mgr,hiredate,Salary,comm,deptno) values (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7876,'ADAM','CLERK',7788,'1987-05-23',1100.00,20);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7900,'JAMES','CLERK',7698,'1981-12-03',950.00,30);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,20);
insert into employee (empno,ename,job,mgr,hiredate,Salary,deptno) values (7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,10);

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPT;


#Q3. List the Names and salary of the employee whose salary is greater than 1000

SELECT ENAME,SALARY FROM EMPLOYEE WHERE SALARY>1000;

#Q4 =List the details of the employees who have joined before end of September 81.

SELECT * FROM EMPLOYEE WHERE HIREDATE <'1981-10-30';

#Q5 =5.	List Employee Names having I as second character.

select ename from employee where substr(ename,2,1)='i';

#Q6 =List Employee Name, Salary, Allowances (40% of Sal),
# P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

SELECT * FROM EMPLOYEE;
SELECT ENAME,SALARY,(SALARY*0.4) AS ALLOWANCE ,(SALARY*0.1) AS PF,(SALARY+(SALARY*0.4)+(SALARY*0.1)) AS NET_SALARY FROM EMPLOYEE;

#Q7.  List Employee Names with designations who does not report to anybody
SELECT * FROM EMPLOYEE;
SELECT ename, job
FROM employee
WHERE mgr IS NULL;

#Q8	List Empno, Ename and Salary in the ascending order of salary.

SELECT EMPNO,ENAME,SALARY FROM EMPLOYEE ORDER BY SALARY ASC;

#Q9 9.	How many jobs are available in the Organization ?

Select distinct(job) from employee;

#Q10 - 10.	Determine total payable salary of salesman category

SELECT SUM(SALARY) AS TOTAL_PAYABLE_SALARY FROM EMPLOYEE WHERE JOB ='SALESMAN';

#Q11 =11.	List average monthly salary for each job within each department   
SELECT * FROM EMPLOYEE;

SELECT AVG(SALARY),JOB ,DEPTNO AS DEPARTMENT FROM EMPLOYEE GROUP BY JOB,DEPTNO ORDER BY DEPTNO ;

#Q12 = 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

select * from employee;
select * from dept;
select e.ename,e.salary,d.dname from employee e join dept d on (e.deptno =d.deptno);


#Q13  Create the Job Grades Table as below
 create table job_grades(
 grade varchar(10),
 lowest_sal int,
 highest_sal int);
 insert into job_grades VALUES ('A',0,999),('B',1000,1999),('C',2000,2999),('D',3000,3999),
 ('E',4000,5000);
 
 SELECT * FROM JOB_GRADES;
 
 #Q14 -14.	Display the last name, salary and  Corresponding Grade.
 
 select * from employee;
 select e.ename ,e.salary,j.grade from employee e join
 job_grades j on e.salary>=j.lowest_sal and e.salary <= highest_sal;  # join with both conditions
 
 #15.	Display the Emp name and the Manager name under whom the Employee works in the below format .
  #Emp Report to Mgr.

select emp.ename as employee_name ,mgr.ename as manager_name
from employee emp
join employee mgr on (emp.mgr = mgr.empno);   #used self join here to get mgr name


#Q16.	Display Empname and Total sal where Total Sal (sal + Comm)
select * from employee;
select ename,(salary+ifnull(comm,0)) as Total_salary from employee;  #used ifnull for replacing null values to 


#17=Display Empname and Sal whose empno is a odd number
select ename, salary from employee where empno %2 =1;

#18.Display Empname , Rank of sal in Organisation , Rank of Sal in their department


select * from employee;
SELECT ename,
  RANK() OVER (PARTITION BY salary) AS org_rank,
  RANK() OVER (PARTITION BY deptno ORDER BY salary) AS dept_rank
FROM employee;


#19.	Display Top 3 Empnames based on their Salary

select ename,salary from employee order by salary desc limit 3;

#20. Display Empname who has highest Salary in Each Department.
select * from employee;


SELECT ename, salary, deptno
FROM (
  SELECT ename, salary, deptno, RANK() OVER (PARTITION BY deptno ORDER BY salary DESC) AS ranka
  FROM employee
) e
WHERE ranka = 1;

#2nd approach

select e1.ename,e1.salary,e1.deptno from employee e1 join( select deptno,max(salary) as max_sal from employee group by deptno) e2

on e1.deptno =e2.deptno and e1.salary=e2.max_sal;










 

