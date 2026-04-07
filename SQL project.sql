create database project;
use project;
create table employees(employee_id INT PRIMARY KEY AUTO_INCREMENT, 
full_name VARCHAR(100) not null, 
age INT, 
gender VARCHAR(10) check(gender In("Male", "Female")), 
department VARCHAR(50) not null check(department in("HR","IT","Finance","Sales","Operations")), 
designation VARCHAR(50) not null check(designation in("HR Associate","Software Engineer", "Senior Developer", "Sales Executive","Finance Analyst", "Operations Manager")),
salary DECIMAL(10,2) not null check(salary>0),
experience_years DECIMAL(4,1),
location VARCHAR(50) not null);

insert into employees(full_name, age, gender, department, designation, salary, experience_years, location) values
("Amit Sharma", 28, "Male", "IT", "Software Engineer", 75000.00, 3.5, "Mumbai"),
("Neha Verma", 32, "Female", "HR", "HR Associate", 32000.00, 6.0, "Delhi"),
("Rahul Mehta", 40, "Male", "IT", "Senior Developer", 120000.00, 12.5, "Bangalore"),
("Sneha Kapoor", 26, "Female", "Sales", "Sales Executive", 42000.00, 2.5, "Pune"),
("Arjun Patel", 35, "Male", "Finance", "Finance Analyst", 65000.00, 8.0, "Ahmedabad"),
("Priya Nair", 45, "Female", "Operations", "Operations Manager", 100000.00, 18.0, "Chennai"),
("Vikas Singh", 29, "Male", "IT", "Software Engineer", 68000.00, 4.0, "Hyderabad"),
("Anjali Desai", 31, "Female", "Finance", "Finance Analyst", 72000.00, 7.5, "Mumbai"),
("Karan Malhotra", 38, "Male", "Sales", "Sales Executive", 50000.00, 10.0, "Delhi"),
("Meera Iyer", 42, "Female", "Operations", "Operations Manager", 115000.00, 16.0, "Bangalore"),
("Rohan Gupta", 27, "Male", "IT", "Software Engineer", 82000.00, 5.0, "Noida"),
("Pooja Sharma", 30, "Female", "HR", "HR Associate", 35000.00, 7.0, "Kolkata"),
("Siddharth Jain", 36, "Male", "Finance", "Finance Analyst", 78000.00, 9.0, "Jaipur"),
("Divya Reddy", 33, "Female", "Sales", "Sales Executive", 47000.00, 6.5, "Chandigarh"),
("Manish Kumar", 48, "Male", "Operations", "Operations Manager", 110000.00, 20.0, "Indore");

select * from employees;

select *,
case
when age between 22 and 30 then "Junior Employees"
when age between 31 and 40 then "Mid-Level Employees"
else "Senior employess"
end
as age_group from employees;

select * from employees;
select full_name,department from employees where department="IT";
select full_name,salary from employees where salary>60000; 

select distinct department from employees;


select * from employees where location="Mumbai";

select * from employees order by salary desc;

select * from employees where full_name like "a%";

select department, round(avg(salary),0) as avg_sal from employees group by department;

select department, count(employee_id) as count_emp from employees group by department;

with displ as (select department,count(employee_id) over (partition by department) as emp_count from employees) 
select distinct department, emp_count from displ where emp_count=
(select max(emp_count) from displ);

SELECT department, COUNT(employee_id) AS emp_count
FROM employees
GROUP BY department
ORDER BY emp_count DESC limit 1;

select * from employees;

select department, sum(salary) as tot_dept_sal from employees group by department;

select department, min(salary) as min_sal,max(salary) as max_sal from employees where department="IT";


select * from employees where experience_years>10;

select *, min(salary) over(partition by designation), max(salary) over(partition by designation) from employees;

with displ1 as
(select *, min(salary) over(partition by designation) as min_sal, 
max(salary) over(partition by designation) as max_sal from employees) 
select *, concat(min_sal,"-",max_sal) as sal_range from displ1;

select * from employees where salary between 50000 and 100000;

select *  from employees where department="Sales"and gender="Female";


select * from employees where experience_years between 2 and 8;

select * from employees;
select l.full_name as low_paid_emp, l.salary as lower_salary, 
h.full_name as high_paid_emp, h.salary as higher_sal 
from employees as l inner join employees as h on l.salary<h.salary;

create view t1 as (select * from employees where salary>80000);

select *from t1;

select * from t1 where experience_years>5;


select *,dense_rank() over(order by salary desc) as rnk from employees;

select full_name, department, salary, round(avg(salary) over(partition by department),0) as avg_sal from employees;

select full_name, department, experience_years, dense_rank() over(partition by department order by experience_years) as rnk from employees;



