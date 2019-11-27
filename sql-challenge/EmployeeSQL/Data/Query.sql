-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT Data_Employee.emp_no,Data_Employee.first_name, Data_Employee.last_name, Data_Employee.gender, Data_Salaries.salary
FROM Data_Salaries
INNER JOIN Data_Employee ON
Data_Employee.emp_no=Data_Salaries.emp_no;


--List employees who were hired in 1986.
SELECT * 
FROM Data_Employee
where hire_date 
	between '1986-01-01' and '1986-12-31';
	

--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT Data_Departments.dept_no,Data_Departments.dept_name, Data_Department_Manager.emp_no,Data_employee.last_name,Data_employee.first_name,Instructions_Data_Titles.from_date,Instructions_Data_Titles.end_date
FROM Data_Departments
INNER JOIN Data_Department_Manager ON Data_Department_Manager.dept_no=Data_Departments.dept_no
INNER JOIN Data_employee ON Data_Employee.emp_no=Data_Department_Manager.emp_no
INNER JOIN Instructions_Data_Titles ON Instructions_Data_Titles.emp_no=Data_Employee.emp_no;


--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT Data_Employee.emp_no,Data_Employee.last_name,Data_Employee.first_name,Data_Departments.dept_name
FROM Data_Departments
INNER JOIN Data_Department_Employee ON Data_Department_Employee.dept_no=Data_Departments.dept_no
INNER JOIN Data_employee ON Data_Employee.emp_no=Data_Department_Employee.emp_no;



--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM Data_Employee
WHERE first_name = 'Hercules' AND last_name like'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT Data_Employee.emp_no,Data_Employee.last_name,Data_Employee.first_name,Data_Departments.dept_name
FROM Data_Departments
INNER JOIN Data_Department_Employee ON Data_Department_Employee.dept_no=Data_Departments.dept_no
INNER JOIN Data_employee ON Data_Employee.emp_no=Data_Department_Employee.emp_no
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, 
--and department name.
SELECT Data_Employee.emp_no,Data_Employee.last_name,Data_Employee.first_name,Data_Departments.dept_name
FROM Data_Departments
INNER JOIN Data_Department_Employee ON Data_Department_Employee.dept_no=Data_Departments.dept_no
INNER JOIN Data_employee ON Data_Employee.emp_no=Data_Department_Employee.emp_no
WHERE dept_name in ('Sales', 'Development');


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(emp_no) AS "Total employee"
FROM Data_Employee
GROUP BY last_name
ORDER by COUNT(emp_no) DESC;

