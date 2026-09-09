
```sql
-- ============================================================
-- SQL VIEWS ASSIGNMENT
-- Database: Company
-- ============================================================


-- ============================================================
-- Part 1 — Simple Views
-- ============================================================

-- Q1)
-- Create a view that displays employees' first name,
-- last name, and salary.

DROP VIEW IF EXISTS employee_basic_view;

CREATE VIEW employee_basic_view AS
SELECT fname,
       lname,
       salary
FROM employee;

SELECT * FROM employee_basic_view;


-- ------------------------------------------------------------

-- Q2)
-- Create a view for employees working in Department 5.

DROP VIEW IF EXISTS research_employees;

CREATE VIEW research_employees AS
SELECT *
FROM employee
WHERE dno = 5
WITH CHECK OPTION;

SELECT * FROM research_employees;


-- ------------------------------------------------------------

-- Q3)
-- Create a view for employees whose salary is greater than 30000.

DROP VIEW IF EXISTS high_salary_employees;

CREATE VIEW high_salary_employees AS
SELECT fname,
       lname,
       salary
FROM employee
WHERE salary > 30000
WITH CHECK OPTION;

SELECT * FROM high_salary_employees;


-- ------------------------------------------------------------

-- Q4)
-- Create a view for female employees.

DROP VIEW IF EXISTS female_employees;

CREATE VIEW female_employees AS
SELECT fname,
       lname,
       sex,
       salary
FROM employee
WHERE sex = 'F';

SELECT * FROM female_employees;


-- ------------------------------------------------------------

-- Q5)
-- Create a view that displays the employee's full name,
-- SSN, and salary.

DROP VIEW IF EXISTS employee_names;

CREATE VIEW employee_names AS
SELECT CONCAT(fname, ' ', minit, ' ', lname) AS full_name,
       ssn,
       salary
FROM employee;

SELECT * FROM employee_names;


-- ------------------------------------------------------------

-- Q6)
-- Create a view for employees working in Department 5.

DROP VIEW IF EXISTS department5_employees;

CREATE VIEW department5_employees AS
SELECT ssn,
       fname,
       lname,
       salary,
       dno
FROM employee
WHERE dno = 5
WITH CHECK OPTION;

SELECT * FROM department5_employees;


-- ------------------------------------------------------------

-- Q7)
-- Create a view that displays employee names and addresses.

DROP VIEW IF EXISTS employee_addresses;

CREATE VIEW employee_addresses AS
SELECT fname,
       lname,
       address
FROM employee;

SELECT * FROM employee_addresses;


-- ------------------------------------------------------------

-- Q8)
-- Create a view for employees whose salary is less than
-- or equal to 25000.

DROP VIEW IF EXISTS low_salary_employees;

CREATE VIEW low_salary_employees AS
SELECT *
FROM employee
WHERE salary <= 25000
WITH CHECK OPTION;

SELECT * FROM low_salary_employees;


-- ============================================================
-- Part 2 — DML Through Simple Views
-- ============================================================

-- Q9)
-- Update an employee's salary through a simple view.

DROP VIEW IF EXISTS the_employees;

CREATE VIEW the_employees AS
SELECT fname,
       lname,
       salary
FROM employee;

UPDATE the_employees
SET salary = 35000
WHERE fname = 'John'
  AND lname = 'Smith';


-- ------------------------------------------------------------

-- Q10)
-- Update an employee's salary through a department view.

DROP VIEW IF EXISTS employees_dept4;

CREATE VIEW employees_dept4 AS
SELECT *
FROM employee
WHERE dno = 4
WITH CHECK OPTION;

UPDATE employees_dept4
SET salary = 28000
WHERE ssn = '999887777';


-- ------------------------------------------------------------

-- Q11)
-- Delete an employee through a view.
--
-- Because the employee may have related records in WORKS_ON,
-- those records should be deleted first if foreign-key
-- constraints do not use ON DELETE CASCADE.

DROP VIEW IF EXISTS employees_delete;

CREATE VIEW employees_delete AS
SELECT fname,
       lname,
       salary
FROM employee;

DELETE FROM works_on
WHERE essn = (
    SELECT ssn
    FROM employee
    WHERE fname = 'Ahmad'
      AND lname = 'Jabbar'
);

DELETE FROM employees_delete
WHERE fname = 'Ahmad'
  AND lname = 'Jabbar';


-- ============================================================
-- Part 3 — Complex Views: JOIN
-- ============================================================

-- Q12)
-- Display employee full name and department name.

DROP VIEW IF EXISTS employee_department_view;

CREATE VIEW employee_department_view AS
SELECT CONCAT(e.fname, ' ', e.lname) AS full_name,
       d.dname
FROM employee AS e
JOIN department AS d
  ON e.dno = d.dnumber;

SELECT * FROM employee_department_view;


-- ------------------------------------------------------------

-- Q13)
-- Display employee full name and project name.

DROP VIEW IF EXISTS employee_projects;

CREATE VIEW employee_projects AS
SELECT CONCAT(e.fname, ' ', e.lname) AS full_name,
       p.pname
FROM employee AS e
JOIN works_on AS w
  ON e.ssn = w.essn
JOIN project AS p
  ON p.pnumber = w.pno;

SELECT * FROM employee_projects;


-- ------------------------------------------------------------

-- Q14)
-- Display project name, project location,
-- and department name.

DROP VIEW IF EXISTS project_department_view;

CREATE VIEW project_department_view AS
SELECT p.pname,
       p.plocation,
       d.dname
FROM project AS p
JOIN department AS d
  ON p.dnum = d.dnumber;

SELECT * FROM project_department_view;


-- ------------------------------------------------------------

-- Q15)
-- Display employee name, project name, and hours worked.

DROP VIEW IF EXISTS employee_project_hours;

CREATE VIEW employee_project_hours AS
SELECT CONCAT(e.fname, ' ', e.lname) AS employee_name,
       p.pname,
       w.hours
FROM employee AS e
JOIN works_on AS w
  ON e.ssn = w.essn
JOIN project AS p
  ON w.pno = p.pnumber;

SELECT * FROM employee_project_hours;


-- ============================================================
-- Part 4 — Complex Views: Aggregate Functions
-- ============================================================

-- Q16)
-- Average salary for each department.

DROP VIEW IF EXISTS department_avg_salary;

CREATE VIEW department_avg_salary AS
SELECT dno,
       ROUND(AVG(salary), 2) AS average_salary
FROM employee
GROUP BY dno;

SELECT * FROM department_avg_salary;


-- ------------------------------------------------------------

-- Q17)
-- Number of employees in each department.

DROP VIEW IF EXISTS department_employee_count;

CREATE VIEW department_employee_count AS
SELECT dno,
       COUNT(*) AS employee_count
FROM employee
GROUP BY dno;

SELECT * FROM department_employee_count;


-- ------------------------------------------------------------

-- Q18)
-- Total salary for each department.

DROP VIEW IF EXISTS department_total_salary;

CREATE VIEW department_total_salary AS
SELECT dno,
       SUM(salary) AS total_salary
FROM employee
GROUP BY dno;

SELECT * FROM department_total_salary;


-- ------------------------------------------------------------

-- Q19)
-- Maximum salary in each department.

DROP VIEW IF EXISTS department_max_salary;

CREATE VIEW department_max_salary AS
SELECT dno,
       MAX(salary) AS max_salary
FROM employee
GROUP BY dno;

SELECT * FROM department_max_salary;


-- ============================================================
-- Part 5 — Complex Views: JOIN + GROUP BY
-- ============================================================

-- Q20)
-- Display each department's name, employee count,
-- and average salary.

DROP VIEW IF EXISTS department_info;

CREATE VIEW department_info AS
SELECT d.dnumber,
       d.dname,
       COUNT(e.ssn) AS employee_count,
       ROUND(AVG(e.salary), 2) AS average_salary
FROM department AS d
LEFT JOIN employee AS e
  ON e.dno = d.dnumber
GROUP BY d.dnumber,
         d.dname;

SELECT * FROM department_info;


-- ------------------------------------------------------------

-- Q21)
-- Total hours worked on each project.

DROP VIEW IF EXISTS project_hours_summary;

CREATE VIEW project_hours_summary AS
SELECT p.pnumber,
       p.pname,
       SUM(w.hours) AS total_hours
FROM project AS p
JOIN works_on AS w
  ON p.pnumber = w.pno
GROUP BY p.pnumber,
         p.pname;

SELECT * FROM project_hours_summary;


-- ------------------------------------------------------------

-- Q22)
-- Total hours worked by each employee.

DROP VIEW IF EXISTS employee_total_hours;

CREATE VIEW employee_total_hours AS
SELECT e.ssn,
       e.fname,
       e.lname,
       SUM(w.hours) AS total_hours
FROM employee AS e
JOIN works_on AS w
  ON w.essn = e.ssn
GROUP BY e.ssn,
         e.fname,
         e.lname;

SELECT * FROM employee_total_hours;


-- ------------------------------------------------------------

-- Q23)
-- Number of projects for each department.

DROP VIEW IF EXISTS department_project_count;

CREATE VIEW department_project_count AS
SELECT d.dnumber,
       d.dname,
       COUNT(p.pnumber) AS project_count
FROM department AS d
LEFT JOIN project AS p
  ON d.dnumber = p.dnum
GROUP BY d.dnumber,
         d.dname;

SELECT * FROM department_project_count;


-- ============================================================
-- Part 6 — More Complex Views
-- ============================================================

-- Q24)
-- Display employee, department, project, and hours.

DROP VIEW IF EXISTS emp_dept_proj_hours;

CREATE VIEW emp_dept_proj_hours AS
SELECT CONCAT(e.fname, ' ', e.lname) AS employee_name,
       d.dname,
       p.pname,
       w.hours
FROM employee AS e
JOIN department AS d
  ON e.dno = d.dnumber
JOIN works_on AS w
  ON w.essn = e.ssn
JOIN project AS p
  ON p.pnumber = w.pno;

SELECT * FROM emp_dept_proj_hours;


-- ------------------------------------------------------------

-- Q25)
-- Total hours spent on research department projects.

DROP VIEW IF EXISTS research_project_hours;

CREATE VIEW research_project_hours AS
SELECT p.pnumber,
       p.pname AS project_name,
       SUM(w.hours) AS total_hours
FROM works_on AS w
JOIN project AS p
  ON p.pnumber = w.pno
WHERE p.dnum = 5
GROUP BY p.pnumber,
         p.pname;

SELECT * FROM research_project_hours;


-- ------------------------------------------------------------

-- Q26)
-- Department with the highest average employee salary.

DROP VIEW IF EXISTS dept_high_avg_salary;

CREATE VIEW dept_high_avg_salary AS
SELECT d.dnumber,
       d.dname,
       d.mgrssn,
       d.mgrstartdate,
       ROUND(AVG(e.salary), 2) AS highest_average
FROM department AS d
JOIN employee AS e
  ON d.dnumber = e.dno
GROUP BY d.dnumber,
         d.dname,
         d.mgrssn,
         d.mgrstartdate
ORDER BY highest_average DESC
LIMIT 1;

SELECT * FROM dept_high_avg_salary;


-- ------------------------------------------------------------

-- Q27)
-- Employees who work on more than one project.

DROP VIEW IF EXISTS employees_more_than_one_project;

CREATE VIEW employees_more_than_one_project AS
SELECT e.ssn,
       e.fname,
       e.lname,
       COUNT(w.pno) AS project_count
FROM employee AS e
JOIN works_on AS w
  ON w.essn = e.ssn
GROUP BY e.ssn,
         e.fname,
         e.lname
HAVING COUNT(w.pno) > 1;

SELECT * FROM employees_more_than_one_project;


-- ------------------------------------------------------------

-- Q28)
-- Employees who work more than 30 hours in total.

DROP VIEW IF EXISTS employees_more_than_30_hours;

CREATE VIEW employees_more_than_30_hours AS
SELECT e.ssn,
       CONCAT(e.fname, ' ', e.lname) AS employee_name,
       SUM(w.hours) AS total_hours
FROM employee AS e
JOIN works_on AS w
  ON w.essn = e.ssn
GROUP BY e.ssn,
         e.fname,
         e.lname
HAVING SUM(w.hours) > 30;

SELECT * FROM employees_more_than_30_hours;


-- ============================================================
-- Part 7 — Simple or Complex?
-- ============================================================

-- Q29)
-- Simple View:
-- It uses only one table and does not contain JOIN,
-- GROUP BY, aggregate functions, DISTINCT, or set operations.
-- DML operations such as UPDATE are generally possible.


-- ------------------------------------------------------------

-- Q30)
-- Complex View:
-- It uses a JOIN between two or more tables.


-- ------------------------------------------------------------

-- Q31)
-- Complex View:
-- It uses an aggregate function (AVG) together with GROUP BY.


-- ------------------------------------------------------------

-- Q32)
-- Simple View:
-- It uses only one table with a WHERE condition.
-- UPDATE is generally allowed through the view.


-- ------------------------------------------------------------

-- Q33)
-- Complex View:
-- It uses JOIN, COUNT(), and GROUP BY.
-- Direct DML operations through this type of view are
-- generally not allowed.


-- ===========================================================
