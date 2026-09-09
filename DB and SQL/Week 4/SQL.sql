drop table if exists empoyees
--1.	Basic SQL Queries:
--○	Write a SQL query to retrieve all columns from a table named employees.

select * from empoyees

--○	Write a SQL query to retrieve the emp_id,
--emp_name, and dept_id from the employees table, where the location is 'Cairo'.

select emp_id, emp_name,dept_id from employess;
where location ='cairo'
------------------------------------------------------------------------------

--2.	DISTINCT Keyword:
-- ○	Write a SQL query that displays distinct dept_id values from the employees table
 select distinct dep_id from empoyees;
-------------------------------------------------------------------------------

-- 3.	Data Definition Language (DDL):
--○	Write a SQL query to create a table students with the following columns: ID (Primary Key),
--First_Name (not null), Last_Name (default 'Unknown'), Address (default 'N/A'),
--City (default 'N/A'), and Birth_Date.


create table students(id int Primary Key, First_Name varchar(50) not null,Last_name varchar(50)default
'Unknown',addess varchar(100)default 'N/A',city varchar(50)default'N/A',Birth_Data data);



--○	Write a SQL query to drop the students table.

drop table student;

------------------------------------------------------------------------------------
-- 4.	Data Manipulation Language (DML):
-- ○	Write a SQL query to insert the following values into the students table:
-- ('Ahmed', 'Ali', 'Downtown', 'Cairo', '1995-01-01').
insert into students(First_Name ,Last_Name, Address,City,Birth_Date)
values ('Ahmed', 'Ali', 'Downtown', 'Cairo', '1995-01-01')


-- ○	Write a SQL query to update the Address of the student with Last_Name = 'Ahmed' to 'Garden City'.

updata student set Adress= 'Gerden City' where Last_Name = 'Ahmed'

 ----------------------------------------------------------------------------------------

--5.	Transaction Control:
--○	Write a SQL query to delete the rows from the students table
--where City is 'Cairo', and then rollback the transaction.

start transaction;
delet from students where City ='cairo' rollbzck









