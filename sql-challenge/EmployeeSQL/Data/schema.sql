CREATE TABLE Data_Departments (
   	dept_no varchar primary key
	, dept_name varchar NULL
	);

--select * 
--from Data_Departments

CREATE TABLE Data_Department_Employee (
    emp_no int NOT NULL
	,dept_no varchar NOT NULL
	,from_date date NOT NULL
	,to_date date NOT NULL
	);
	
--select * 
--from Data_Department_Employee

CREATE TABLE Data_Department_Manager (
    dept_no varchar NOT NULL
	,emp_no int NOT NULL
	,from_date date NOT NULL
	,to_date date NOT NULL
	);
	
--select * 
--from Data_Department_Manager

CREATE TABLE Data_Employee (
    emp_no int NOT NULL
	,birth_date date NOT NULL
	,first_name varchar NOT NULL
	,last_name varchar NOT NULL
	,gender varchar NOT NULL
	,hire_date date NOT NULL
);

--select * 
--from Data_Employee


CREATE TABLE Data_Salaries (
    emp_no int NOT NULL
	,salary int NOT NULL
	,from_date date NOT NULL
	,to_date date NOT NULL
);

--select * 
--from Data_Salaries


CREATE TABLE Instructions_Data_Titles (
    emp_no int NOT NULL
	,title varchar NOT NULL
	,from_date date NOT NULL
	,end_date date NOT NULL
);

--select * 
--from Instructions_Data_Titles

