
create database meher_09;
show databases;
use  meher_09;



 create TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  birth_date DATE,
  sex CHAR(255),
  salary DECIMAL(10, 2),
  super_id INT,
  branch_id INT
);
 select * from employees;
 
 
CREATE TABLE branches (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(255),
  mgr_id INT,
  mgr_start_date DATE
);
select * from branches;
CREATE TABLE clients (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(255),
  branch_id INT
);
select * from clients;
CREATE TABLE sales (
  emp_id INT,
  client_id INT,
  total_sales DECIMAL(10, 2),
  PRIMARY KEY (emp_id, client_id),
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
select * from sales;

CREATE TABLE suppliers (
  branch_id INT,
  supplier_name VARCHAR(255),
  supply_type VARCHAR(255),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
select * from suppliers;
INSERT INTO employees (emp_id, first_name, last_name, birth_date, sex, salary, super_id, branch_id)
VALUES
  (100, 'David', 'Wallace', '1967-11-17', 'M', 250000.00, NULL, 1),
  (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000.00, 100, 1),
  (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000.00, 100, 2),
  (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000.00, 102, 2),
  (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000.00, 102, 2),
  (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000.00, 102, 2),
  (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000.00, 100, 3),
  (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000.00, 106, 3),
  (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000.00, 106, 3);
  
  
INSERT INTO branches (branch_id, branch_name, mgr_id, mgr_start_date)
VALUES
  (1, 'Corporate', 100, '2006-02-09'),
  (2, 'Scranton', 102, '1992-04-06'),
  (3, 'Stamford', 106, '1998-02-13');
  
INSERT INTO clients (client_id, client_name, branch_id)
VALUES
  (400, 'Dunmore Highschool', 2),
  (401, 'Lackawana Country', 2),
  (402, 'FedEx', 3),
  (403, 'John Daly Law, LLC', 3),
  (404, 'Scranton Whitepages', 2),
  (405, 'Times Newspaper', 3),
  (406, 'FedEx', 2);
  
INSERT INTO sales (emp_id, client_id, total_sales)
VALUES
  (105, 400, 55000.00),
  (102, 401, 267000.00),
  (108, 402, 22500.00),
  (107, 403, 5000.00),
  (108, 403, 12000.00),
  (105, 404, 33000.00),
  (107, 405, 26000.00),
  (102, 406, 15000.00),
  (105, 406, 130000.00);
  
INSERT INTO suppliers (branch_id, supplier_name, supply_type)
VALUES
  (2, 'Hammer Mill', 'Paper'),
  (2, 'Uni-ball', 'Writing Utensils'),
  (3, 'Patriot Paper', 'Paper'),
  (2, 'J.T. Forms & Labels', 'Custom Forms'),
  (3, 'Uni-ball', 'Writing Utensils'),
  (3, 'Hammer Mill', 'Paper'),
  (3, 'Stamford Lables', 'Custom Forms');
  
  select * from employees;
  select * from branches;
  select *  from clients;
  select * from sales;
  select * from  suppliers;
  -- questions 
  -- 1 
  select  max(salary) as high_salary from employees e 
  join branches b on e.branch_id=b.branch_id 
  where sex= 'f' and branch_name ='corporate';
  
  -- 2
 select e.*, COUNT(s.client_id) AS client_count
from employees e
join sales s on e.emp_id = s.emp_id
where e.salary > 50000
group by e.emp_id;

-- 3
select avg(salary) as avg_salary from employees e join 
branches b on e.branch_id= b.branch_id
where branch_name ='scranton' and sex='m';

-- 4 
select c.branch_id, COUNT(*) AS client_count from clients c
group by c.branch_id
having COUNT(*) > 5;

-- 5
select e.emp_id ,e.first_name ,e. last_name, sum(s.total_sales) as total_sales from employees e
join sales s on e.emp_id= s.emp_id
join branches b on e.branch_id=b.branch_id
where branch_name='corporate' 
group by emp_id 
having sum(s.total_sales) > 1000000;

-- 6
select c.client_id,c.client_name,sum(total_sales) as total_sales from clients c
join sales s on c.client_id=s.client_id
join branches b on b.branch_id=c.branch_id
where b.branch_name='corporate'
group by c.client_id ;
  
  -- 7
 select * from employees 
 where sex='f' and salary > 70000;  
 
 -- 8
SELECT *
FROM clients
WHERE client_name LIKE 'T%';

-- 9
select first_name,last_name, salary from employees 
order by salary desc; 

-- 10
select client_name from clients 
order by client_name asc;

-- 11
select c.client_id ,c.client_name,s.total_sales from clients c
join  sales s on c.client_id=s.client_id
order by total_sales desc;
 
 -- 12 
 select last_name from employees
   where last_name like '%son';
   
   -- 13
  select supplier_name from suppliers 
  where supplier_name like '%paper';
  
  -- 14
  select first_name,last_name,salary from employees
  order by salary asc;
  
  -- 15
  select branch_name from branches
  order by branch_name asc;
  
  -- 16 
  select supplier_name,supply_type from suppliers 
  order by  supply_type;
  
  -- 17
  select sex, avg(salary) from employees 
  group by sex;
  
  -- 18
  SELECT branch_id, COUNT(*) AS client_count
FROM clients
GROUP BY branch_id;

-- 19
SELECT client_id, MAX(total_sales) AS max_sales
FROM sales
GROUP BY client_id;

-- 20
SELECT b.branch_name, COUNT(e.emp_id) AS employee_count
FROM branches b
LEFT JOIN employees e ON b.branch_id = e.branch_id
GROUP BY b.branch_id;

-- 21
SELECT emp_id, COUNT(client_id) AS client_count
FROM sales
GROUP BY emp_id;

-- 22
SELECT branch_id, AVG(EXTRACT(YEAR FROM birth_date)) AS avg_birth_year
FROM employees
GROUP BY branch_id;

  
  
  
  
  
  
  
  
  
  
  
  
  
