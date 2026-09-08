-- ============================================================
-- Q1
-- ============================================================
CREATE VIEW employee_basic_view AS
SELECT fname, lname, salary
FROM employee;

-- ============================================================
-- Q2
-- ============================================================
CREATE VIEW research_employees AS
SELECT *
FROM employee
WHERE dno = 5;

-- ============================================================
-- Q3
-- ============================================================
CREATE VIEW high_salary_employees AS
SELECT fname, lname, salary
FROM employee
WHERE salary > 30000;

-- ============================================================
-- Q4
-- ============================================================
CREATE VIEW female_employees AS
SELECT fname, lname, sex, salary
FROM employee
WHERE sex = 'F';

-- ============================================================
-- Q5
-- ============================================================
CREATE VIEW employee_names AS
SELECT ssn, 
       CONCAT(fname, ' ', minit, ' ', lname) AS full_name,
       salary
FROM employee;

-- ============================================================
-- Q6
-- ============================================================
CREATE VIEW department5_employees AS
SELECT ssn, fname, lname, salary, dno
FROM employee
WHERE dno = 5;

-- ============================================================
-- Q7
-- ============================================================
CREATE VIEW employee_addresses AS
SELECT fname, lname, address
FROM employee;

-- ============================================================
-- Q8
-- ============================================================
CREATE VIEW low_salary_employees AS
SELECT fname, lname, salary
FROM employee
WHERE salary <= 25000;

-- ============================================================
-- Q9
-- ============================================================
CREATE VIEW emp_salary_view AS
SELECT fname, lname, salary
FROM employee;

UPDATE emp_salary_view
SET salary = 35000
WHERE fname = 'John' AND lname = 'Smith';

-- ============================================================
-- Q10
-- ============================================================
CREATE VIEW dept4_employees AS
SELECT fname, lname, salary
FROM employee
WHERE dno = 4;

UPDATE dept4_employees
SET salary = 28000
WHERE fname = 'Alicia' AND lname = 'Zelaya';

-- ============================================================
-- Q11
-- ============================================================
CREATE VIEW all_employees_view AS
SELECT fname, lname, salary
FROM employee;

DELETE FROM all_employees_view
WHERE fname = 'Ahmad' AND lname = 'Jabbar';

-- ============================================================
-- Q12
-- ============================================================
CREATE VIEW employee_department_view AS
SELECT e.fname, e.lname, d.dname AS department_name
FROM employee e
JOIN department d ON e.dno = d.dnumber;

-- ============================================================
-- Q13
-- ============================================================
CREATE VIEW employee_projects AS
SELECT e.fname, e.lname, p.pname
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;

-- ============================================================
-- Q14
-- ============================================================
CREATE VIEW project_department_view AS
SELECT p.pname, p.plocation, d.dname
FROM project p
JOIN department d ON p.dnum = d.dnumber;

-- ============================================================
-- Q15
-- ============================================================
CREATE VIEW employee_project_hours AS
SELECT e.fname, e.lname, p.pname, w.hours
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;

-- ============================================================
-- Q16
-- ============================================================
CREATE VIEW department_avg_salary AS
SELECT dno, AVG(salary) AS average_salary
FROM employee
GROUP BY dno;

-- ============================================================
-- Q17
-- ============================================================
CREATE VIEW department_employee_count AS
SELECT dno, COUNT(*) AS employee_count
FROM employee
GROUP BY dno;

-- ============================================================
-- Q18
-- ============================================================
CREATE VIEW department_total_salary AS
SELECT dno, SUM(salary) AS total_salary
FROM employee
GROUP BY dno;

-- ============================================================
-- Q19
-- ============================================================
CREATE VIEW department_max_salary AS
SELECT dno, MAX(salary) AS max_salary
FROM employee
GROUP BY dno;

-- ============================================================
-- Q20
-- ============================================================
CREATE VIEW department_info AS
SELECT d.dname, 
       COUNT(e.ssn) AS employee_count,
       AVG(e.salary) AS average_salary
FROM department d
JOIN employee e ON d.dnumber = e.dno
GROUP BY d.dname;

-- ============================================================
-- Q21
-- ============================================================
CREATE VIEW project_hours_summary AS
SELECT p.pname, SUM(w.hours) AS total_hours
FROM project p
JOIN works_on w ON p.pnumber = w.pno
GROUP BY p.pname;

-- ============================================================
-- Q22
-- ============================================================
CREATE VIEW employee_total_hours AS
SELECT e.fname, e.lname, SUM(w.hours) AS total_hours
FROM employee e
JOIN works_on w ON e.ssn = w.essn
GROUP BY e.fname, e.lname;

-- ============================================================
-- Q23
-- ============================================================
CREATE VIEW department_project_count AS
SELECT d.dname, COUNT(p.pnumber) AS project_count
FROM department d
LEFT JOIN project p ON d.dnumber = p.dnum
GROUP BY d.dname;

-- ============================================================
-- Q24
-- ============================================================
CREATE VIEW employee_dept_project_hours AS
SELECT e.fname, e.lname, d.dname AS department_name, 
       p.pname AS project_name, w.hours
FROM employee e
JOIN department d ON e.dno = d.dnumber
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;

-- ============================================================
-- Q25
-- ============================================================
CREATE VIEW research_project_hours AS
SELECT p.pname, SUM(w.hours) AS total_hours
FROM project p
JOIN works_on w ON p.pnumber = w.pno
WHERE p.dnum = 5
GROUP BY p.pname;

-- ============================================================
-- Q26
-- ============================================================
CREATE VIEW department_highest_avg_salary AS
SELECT d.dname, AVG(e.salary) AS avg_salary
FROM department d
JOIN employee e ON d.dnumber = e.dno
GROUP BY d.dname
ORDER BY avg_salary DESC
LIMIT 1;

-- ============================================================
-- Q27
-- ============================================================
CREATE VIEW employees_more_than_one_project AS
SELECT e.fname, e.lname, COUNT(w.pno) AS project_count
FROM employee e
JOIN works_on w ON e.ssn = w.essn
GROUP BY e.fname, e.lname
HAVING COUNT(w.pno) > 1;

-- ============================================================
-- Q28
-- ============================================================
CREATE VIEW employees_total_hours_greater_than_30 AS
SELECT e.fname, e.lname, SUM(w.hours) AS total_hours
FROM employee e
JOIN works_on w ON e.ssn = w.essn
GROUP BY e.fname, e.lname
HAVING SUM(w.hours) > 30;

-- ============================================================
-- Q29
-- ============================================================
CREATE VIEW v1 AS 
SELECT fname, lname, salary 
FROM employee;

-- ============================================================
-- Q30
-- ============================================================
CREATE VIEW v2 AS 
SELECT e.fname, d.dname 
FROM employee e 
JOIN department d ON e.dno = d.dnumber;

-- ============================================================
-- Q31
-- ============================================================
CREATE VIEW v3 AS 
SELECT dno, AVG(salary) 
FROM employee 
GROUP BY dno;

-- ============================================================
-- Q32
-- ============================================================
CREATE VIEW v4 AS 
SELECT * 
FROM employee 
WHERE salary > 30000;

-- ============================================================
-- Q33
-- ============================================================
CREATE VIEW v5 AS 
SELECT dname, COUNT(*) 
FROM department d 
JOIN employee e ON d.dnumber = e.dno 
GROUP BY dname;

-- ============================================================
-- 1
-- ============================================================
CREATE VIEW simple_employee_view AS
SELECT fname, lname, salary FROM employee;

-- ============================================================
-- 2
-- ============================================================
CREATE VIEW research_employee_view AS
SELECT * FROM employee WHERE dno = 5;

-- ============================================================
-- 3
-- ============================================================
CREATE VIEW employee_department_view AS
SELECT e.fname, e.lname, d.dname
FROM employee e JOIN department d ON e.dno = d.dnumber;

-- ============================================================
-- 4
-- ============================================================
CREATE VIEW employee_project_view AS
SELECT e.fname, e.lname, p.pname
FROM employee e
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;

-- ============================================================
-- 5
-- ============================================================
CREATE VIEW department_avg_salary AS
SELECT dno, AVG(salary) AS avg_salary
FROM employee GROUP BY dno;

-- ============================================================
-- 6
-- ============================================================
CREATE VIEW department_employee_count AS
SELECT dno, COUNT(*) AS emp_count
FROM employee GROUP BY dno;

-- ============================================================
-- 7
-- ============================================================
CREATE VIEW employee_total_hours AS
SELECT e.fname, e.lname, SUM(w.hours) AS total_hours
FROM employee e
JOIN works_on w ON e.ssn = w.essn
GROUP BY e.fname, e.lname;

-- ============================================================
-- 8
-- ============================================================
CREATE VIEW project_total_hours AS
SELECT p.pname, SUM(w.hours) AS total_hours
FROM project p
JOIN works_on w ON p.pnumber = w.pno
GROUP BY p.pname;

-- ============================================================
-- 9
-- ============================================================
CREATE VIEW department_project_count AS
SELECT d.dname, COUNT(p.pnumber) AS project_count
FROM department d
LEFT JOIN project p ON d.dnumber = p.dnum
GROUP BY d.dname;

-- ============================================================
-- 10
-- ============================================================
CREATE VIEW employees_more_than_one_project AS
SELECT e.fname, e.lname, COUNT(w.pno) AS project_count
FROM employee e
JOIN works_on w ON e.ssn = w.essn
GROUP BY e.fname, e.lname
HAVING COUNT(w.pno) > 1;
