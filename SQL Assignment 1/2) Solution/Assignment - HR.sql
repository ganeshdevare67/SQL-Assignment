USE HR;
SELECT SUM(salary)
FROM EMPLOYEES;
#Q.1 Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
SELECT first_name "First Name",  last_name "Last Name" 
	FROM employees;

# Q.2 Write a query to get unique department ID from employee table
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

# Q.3 Write a query to get all employee details from the employee table order by first name, descending
SELECT * from EMPLOYEES ORDER BY first_name DESC;

# Q.4 Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary)
SELECT first_name "first_name", last_name "last_name", salary, salary*.15 PF 
	FROM employees;

# Q.5 Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY;

# Q.6 Write a query to get the total salaries payable to employees
SELECT sum(SALARY) FROM EMPLOYEES;

# Q.7 Write a query to get the maximum and minimum salary from employees table
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEES; 

# Q.8 Write a query to get the average salary and number of employees in the employees table
SELECT avg(SALARY), COUNT(employee_id) FROM EMPLOYEES;

# Q.9 Write a query to get the number of employees working with the company
SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES;

# Q.10 Write a query to get the number of jobs available in the employees table
SELECT COUNT(DISTINCT JOB_ID) FROM EMPLOYEES;

# Q.11 Write a query get all first name from employees table in upper case
SELECT UPPER(FIRST_NAME) FROM EMPLOYEES;

# Q.12 Write a query to get the first 3 characters of first name from employees table
SELECT SUBSTRING(FIRST_NAME, 1, 3) FROM EMPLOYEES;
# SELECT SUBSTRING(UPPER(FIRST_NAME), 1, 3) FROM EMPLOYEES;

# Q.13 Write a query to get first name from employees table after removing white spaces from both side
SELECT TRIM(FIRST_NAME) FROM EMPLOYEES;

# Q.14 Write a query to get the length of the employee names (first_name, last_name) from employees table
SELECT length(FIRST_NAME), LENGTH(LAST_NAME) FROM EMPLOYEES;

# Q.15 Write a query to check if the first_name fields of the employees table contains numbers
SELECT * FROM employees 
   WHERE  first_name REGEXP  '[0-9]';
# REGEXP : REGEXP is the operator used when performing regular expression pattern matches. RLIKE is the synonym.

# Q.16 Write a query to display the name (first_name, last_name) and salary for all employees whose salary is
# not in the range $10,000 through $15,000   
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000;

# Q.17 Write a query to display the name (first_name, last_name) and department ID of all employees in
#departments 30 or 100 in ascending order
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(30,100)
ORDER BY DEPARTMENT_ID ASC;

# Q.18 Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID FROM EMPLOYEES
WHERE (SALARY NOT BETWEEN 10000 AND 15000) 
AND DEPARTMENT_ID IN (30,100);

# Q.19 Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE FROM EMPLOYEES
WHERE YEAR(HIRE_DATE) LIKE "1987%";

# Q.20 Write a query to display the first_name of all employees who have both "b" and "c" in their first name
SELECT FIRST_NAME FROM hr.EMPLOYEES
WHERE FIRST_NAME LIKE "%B%"
AND FIRST_NAME LIKE "%C%";

# Q.21 Write a query to display the last name, job, and salary for all employees whose job is that of a
# Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000
SELECT LAST_NAME, JOB_ID, SALARY FROM EMPLOYEES
WHERE JOB_ID IN("IT_PROG", "SH_CLERK")
AND SALARY NOT IN(4500,10000,15000);

# Q.22 Write a query to display the last name of employees whose names have exactly 6 characters
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '______';

# Q.23 Write a query to display the last name of employees having 'e' as the third character
SELECT LAST_NAME 
FROM EMPLOYEES 
WHERE LAST_NAME LIKE '__e%';
USE HR;
# Q.24 Write a query to get the job_id and related employee's id
SELECT JOB_ID, GROUP_CONCAT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY JOB_ID;

# Q.25 Write a query to update the portion of the phone_number in the employees table, within the phone
# number the substring '124' will be replaced by '999'
UPDATE EMPLOYEES
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE PHONE_NUMBER LIKE "%124%";
SELECT PHONE_NUMBER FROM EMPLOYEES;

# Q.26 Write a query to get the details of the employees where the length of the first name greater than or equal to 8
SELECT FIRST_NAME FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME)>=8;

# Q.27 Write a query to append '@example.com' to email field
UPDATE EMPLOYEES SET EMAIL = CONCAT(EMAIL, '@example.com');
SELECT EMAIL FROM EMPLOYEES;

# Q.28 Write a query to extract the last 4 character of phone numbers
SELECT RIGHT(PHONE_NUMBER, 4) AS 'PH_NO.' FROM EMPLOYEES;
use hr;
# Q.29 Write a query to get the last word of the street address
SELECT location_id, street_address, 
SUBSTRING_INDEX(street_address,' ',-1) 
AS 'Last-word-of-street_address' 
FROM locations;
USE HR;
SELECT street_address, SUBSTRING_INDEX(street_address,' ', -1) as Street_address_last_word from locations ;

# Q.30 Write a query to get the locations that have minimum street length
SELECT * FROM LOCATIONS
WHERE LENGTH(STREET_ADDRESS) <= (SELECT  MIN(LENGTH(STREET_ADDRESS)) 
FROM LOCATIONS);
SELECT COUNT("SIZE_OF_STREET_A") FROM
(SELECT LENGTH(STREET_ADDRESS) AS "SIZE OF STREET_A" FROM LOCATIONS) AS STREET;
select * FROM LOCATIONS;
SELECT LENGTH(STREET_ADDRESS) AS "SIZE OF STREET_A" FROM LOCATIONS;
# Q.31 Write a query to display the first word from those job titles which contains more than one words
SELECT JOB_TITLE, SUBSTR(JOB_TITLE,1 ,instr(JOB_TITLE, ' ')-1)
FROM JOBS;
SELECT INSTR('GANESH DEVARE', 'D');

# SELECT REVERSE(LCASE("gANESH WEDS POOJA"));

# Q.32 Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES 
WHERE INSTR(LAST_NAME, "c")>2;

# Q.33 Write a query that displays the first name and the length of the first name for all employees whose
# name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the
# employees' first names
SELECT FIRST_NAME "Name",
LENGTH(FIRST_NAME) "LENGTH"
FROM EMPLOYEES
WHERE FIRST_NAME LIKE "A%"
OR FIRST_NAME LIKE "J%"
OR FIRST_NAME LIKE "M%"
ORDER BY FIRST_NAME;

# Q.34 Write a query to display the first name and salary for all employees. Format the salary to be 10
# characters long, left-padded with the $ symbol. Label the column SALARY
SELECT FIRST_NAME, 
LPAD(SALARY, 10,'$')SALARY 
FROM EMPLOYEES;

# Q.35 Write a query to display the first eight characters of the employees' first names and indicates the
# amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in
# descending order of salary
SELECT LEFT(first_name, 8),
REPEAT('$', FLOOR(salary/1000)) 
'SALARY($)', salary
FROM employees
ORDER BY salary DESC;
use hr;
# Q.36 Write a query to display the employees with their code, first name, last name and hire date who hired
# either on seventh day of any month or seventh month in any year
SELECT employee_id,first_name,last_name,hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;
