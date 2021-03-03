CREATE TABLE Titles (
	title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
	PRIMARY KEY (title_id)
);
SELECT * from Titles;

CREATE TABLE Employees (
    emp_no INTEGER   NOT NULL,
	title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (title_id) REFERENCES Titles(title_id)
);
SELECT * from Employees;

CREATE TABLE Salaries (
    emp_no INTEGER   NOT NULL,
	salary INTEGER   NOT NULL,   
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);
SELECT * from Salaries;

CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
	PRIMARY KEY (dept_no)
);
select * from Departments;

CREATE TABLE Department_Employees (
    emp_no INTEGER   NOT NULL,
	dept_no VARCHAR   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
select * from Department_Employees;

CREATE TABLE Department_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INTEGER   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
SELECT * from Department_Manager;

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex,
Salaries.salary
FROM Employees
INNER JOIN Salaries ON
Employees.emp_no = Salaries.emp_no;

SELECT emp_no, first_name, last_name, hire_date from Employees
WHERE hire_date > '1985-12-31'
AND hire_date < '1987-01-01';

SELECT Department_Manager.dept_no, 
	   Departments.dept_name,
	   Department_Manager.emp_no,
	   Employees.last_name,
	   Employees.first_name
FROM Department_Manager
INNER JOIN Departments ON
Department_Manager.dept_no = Departments.dept_no
INNER JOIN Employees ON
Department_Manager.emp_no = Employees.emp_no;

SELECT Employees.emp_no, 
	   Employees.last_name, 
	   Employees.first_name,
	   Departments.dept_name
FROM Employees
INNER JOIN Department_Manager ON
Employees.emp_no = Department_Manager.emp_no
INNER JOIN Departments ON
Department_Manager.dept_no = Departments.dept_no;

SELECT * FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
JOIN Department_Employees ON
e.emp_no = Department_Employees.emp_no
INNER JOIN Departments AS d ON
Department_Employees.dept_no = d.dept_no
WHERE dept_name = 'Sales';

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
JOIN Department_Employees ON
e.emp_no = Department_Employees.emp_no
INNER JOIN Departments AS d ON
Department_Employees.dept_no = d.dept_no
WHERE (dept_name = 'Sales' OR dept_name = 'Development');
	  
SELECT last_name, COUNT(last_name) 
FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;