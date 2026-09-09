
-- SQL Practice — 20 New Questions
-- PostgreSQL — Company Database

-- 1) Employees Born Before 1965
-- Show the employees whose date of birth is before the year 1965.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • bdate
-- Order the results from oldest to most recent by date of birth.
-- Concepts:
-- • WHERE
-- • Date comparison
-- • ORDER BY
----------------------------------------------------

select fname,lname,bdate from employee where bdate <'1965-01-01'
order by bdate asc;


--===============================================
-- 2) Employees With Salary Between 25000 and 40000
-- Show the employees whose salary is between 25000 and 40000, inclusive.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • salary
-- Use BETWEEN.
--------------------------------------------------

select fname,lname,salary from employee where salary between 25000 and 40000;

--=================================================
-- 3) Employees From Specific Departments
-- Show the employees who work in departments: Department 4, Department 5.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • dno
-- Use IN instead of writing multiple ORs.
-- -----------------------------------------------------------

select fname,lname,dno from employee where dno in(4,5);

--============================================================
-- 4) Employees Whose Last Name Starts With S
-- Show the employees whose last name starts with the letter S.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • salary
-- Use LIKE.
--------------------------------------------------------------
select fname,lname,salary from employee where lname ilike 's%';


--===============================================================
-- 5) Employees With Salary Above 30000 and Born Before 1970
-- Show the employees whose salary is greater than 30000 and whose date of birth is before 1970-01-01.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • bdate
-- • salary
-- Concepts:
-- • AND
-- • Date comparison
-- • Numeric comparison
---------------------------------------------------------------------

select fname,lname,bdate,salary from employee where salary>30000 and bdate<'1970-01-01';

--====================================================================
-- 6) Department Managers
-- Show the department name and the name of the employee who acts as manager of that department.
-- You'll need to join department and employee using mgrssn.
-- Required (SELECT columns):
-- • dname
-- • fname
-- • lname
-- • mgrstartdate
------------------------------------------------------------------------

select dname,fname,lname,mgrstartdate from department join employee on mgrssn=ssn ;

--======================================================================
-- 7) Employees and Their Department Locations
-- Show employees along with the location of the department they work in.
-- You'll need to use employee, department, dept_locations.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • dname
-- • dlocation
-- Note: if a department has more than one location, the employee may appear more than once.

----------------------------------------------------------------------------

select fname,lname,dname,dlocation from department join employee on dno = department.dnumber
join dept_locations on department.dnumber =dept_locations.dnumber ;

--=========================================================================
-- 8) Employees Working on ProductX
-- Show the data of employees who work on the project: ProductX.
-- You'll need to join employee → works_on → project.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • pname
-- • hours
-----------------------------------------------------------------------------
select fname,lname,pname,hours from employee join works_on on ssn=essn 
join project on pno=pnumber
where pname='ProductX';
--===========================================================================
-- 9) Employees Working More Than 20 Hours on a Project
-- Show the employees who work more than 20 hours on any project.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • pname
-- • hours
-- Order the results by hours from highest to lowest.
----------------------------------------------------------------

select fname,lname,pname,hours from employee join works_on on ssn=essn 
join project on pno=pnumber
where hours >20
order by hours DESC;

--================================================================
-- 10) Total Hours for Each Employee
-- Calculate the total working hours for each employee.
-- Use SUM() and GROUP BY.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • total_hours
-- Note: focus only on employees who exist in works_on.
------------------------------------------------------------------------
select fname,lname,sum(hours)as total_hours 
from employee join works_on on ssn=essn
group by ssn ,fname, lname;

--===================================================================
-- 11) Number of Projects for Each Employee
-- Show the number of projects each employee works on.
-- Use COUNT() and GROUP BY.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • project_count
-------------------------------------------------------------------------------

select fname,lname,count(*)as project_count
from employee join works_on on ssn=essn
group by ssn ,fname, lname;

--=======================================================
-- 12) Employees Working on Exactly Two Projects
-- Show the employees who work on exactly two projects.
-- Think about using GROUP BY then HAVING.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • project_count
----------------------------------------------------------------------------------

select fname,lname,count(*)as project_count
from employee join works_on on ssn=essn
group by ssn ,fname, lname
having count(*)=2;

--==============================================================
-- 13) Projects With Total Hours Greater Than 30
-- Show the projects whose total working hours is greater than 30.
-- Required (SELECT columns):
-- • pname
-- • total_hours
-- Concepts:
-- • SUM()
-- • GROUP BY
-- • HAVING
----------------------------------

select pname,sum(hours)as total_hours
from project join works_on on pnumber = pno
group by pnumber,pname
having sum(hours)>30;

--===================================================
-- 14) Departments With Average Salary Between 25000 and 40000
-- Show the departments whose average employee salary is between 25000 and 40000.
-- Required (SELECT columns):
-- • dno
-- • average_salary
-- Use AVG(), GROUP BY, HAVING, BETWEEN.

-------------------------------

select dno,AvG(salary) as average_salary from employee 
group by dno
having AvG(salary) 
between 25000 and 40000;

--===================================================
-- 15) Department With the Highest Average Salary
-- Show the department with the highest average salary.
-- Required (SELECT columns):
-- • dname
-- • average_salary
-- Important: do not use window functions. Think about GROUP BY, AVG(), ORDER BY, LIMIT.
----------------------------------

select dname,AvG(salary) as average_salary from department
join employee on dnumber =dno
group by dnumber,dname
order by  average_salary desc
limit 1;
--=========================================================
-- 16) Employees Who Work on Projects Controlled by Another Department
-- Show the employees who work on a project that belongs to a department different from the department the
-- employee works in.
-- Example idea: an employee works in Department 5 but works on a project that belongs to Department 4.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • employee_department
-- • pname
-- • project_department
-- Concepts:
-- • Multiple JOINs
-- • Comparison between columns
-------------------------------------
select fname,lname,employee.dno as employee_department,pname,project.dnum as project_department
from employee join works_on on ssn=essn
join project on pno=pnumber
where employee.dno <> project.dnum  ;
--==================================================================================
-- 17) Employees Who Work More Than 10 Hours on Projects in Stafford
-- Show the employees who work more than 10 hours on projects located in Stafford.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • pname
-- • hours
-- Concepts:
-- • Multiple JOINs
-- • WHERE
-- • Comparison
----------------------------------

select fname,lname,pname,hours from employee join works_on on ssn=essn
join project on pno=pnumber
where plocation ='Stafford' and hours >10;

--=========================================================
-- 18) Employees Who Have Dependents
-- Show the names of employees who have dependents.
-- Each employee should appear only once, even if they have more than one dependent.
-- Required (SELECT columns):
-- • fname
-- • lname
-- Hint: think about DISTINCT and the tables employee, dependent.
------------------------------------

 select distinct fname,lname from employee join dependent on ssn =essn;

 --================================================================
-- 19) Employees Who Have the Same Salary as Another Employee
-- Show the employees who have the same salary as another employee.
-- Example: if there are 3 employees with a salary of 25000, they should all appear.
-- Required (SELECT columns):
-- • fname
-- • lname
-- • salary
-- Important: use a SELF JOIN, and don't let an employee be compared to themself.
-- Concepts:
-- • Self Join
-- • Table Aliases
-- • <>
-- • =
-----------------------------------------

 select distinct e.fname, e.lname,e.salary from employee e join employee as another_employee
 on e.salary=another_employee.salary
 where e.ssn<>another_employee.ssn;
 
 --=============================================================
-- 20) FINAL CHALLENGE — Department Project Report
-- Build a report for each department that includes:
-- • Department Name
-- • Number of Employees
-- • Total Salary
-- • Average Salary
-- • Number of Projects
-- • Total Project Hours
-- Tables needed:
-- • department
-- • employee
-- • project
-- • works_on
-- Requirements:
-- • Join employees to departments
-- • Count the number of employees in each department
-- • Calculate the total employee salary in each department
-- • Calculate the average employee salary in each department
-- • Count the number of projects belonging to each department
-- • Calculate the total hours worked on each department's projects
-- • Group the results by department
-- • Order the departments by Total Salary from highest to lowest

---------------------------------------------
SELECT 
    dname,
    COUNT(distinct ssn) as num_employees,
    SUM(salary) as total_salary,
    AVG(salary) as avg_salary,
    COUNT(distinct pnumber) as num_projects,
    SUM(hours) AS total_hours
FROM department
JOIN employee ON dnumber = dno
JOIN project ON dnumber = dnum
JOIN works_on ON pnumber = pno
GROUP BY dnumber, dname
ORDER BY total_salary DESC;