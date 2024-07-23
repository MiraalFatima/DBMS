select * from Employee;
select * from Departments;
select * from Locations;
select * from Jobs;

----------QUESTION 1--------
---find the name (first_name, last_name) and the salary of the employees who have a higher
--salary than the employee whose last_name=‘Bull’
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS Employee_Name,
    SALARY
FROM 
    Employee
WHERE 
    SALARY > (SELECT SALARY 
              FROM Employee 
              WHERE LAST_NAME = 'Bull');
---Q2.find the name (first_name, last_name) of all employees who works in the IT department.
SELECT e. FIRST_NAME, e.LAST_NAME FROM
Employee e
JOIN
Departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
where d.DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM Departments WHERE DEPARTMENT_NAME = 'IT'); 
SELECT 
    FIRST_NAME,
    LAST_NAME
FROM 
    Employee
WHERE 
    DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM Departments WHERE DEPARTMENT_NAME = 'IT');
select * from Employee;
---Q3.
SELECT FIRST_NAME,LAST_NAME , DEPARTMENT_ID
FROM 
   Employee
WHERE 
    MANAGER_ID <>0 AND DEPARTMENT_ID IN( 
	SELECT DEPARTMENT_ID 
	FROM 
	Departments WHERE LOCATION_ID IN(
	SELECT LOCATION_ID 
	FROM
	Locations WHERE country_id = 'US'));
	--------
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME
	
FROM 
    Employee e
JOIN 
    Departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN 
    Locations l ON d.LOCATION_ID = l.location_id
WHERE 
    e.MANAGER_ID IS NOT NULL
    AND l.country_id = 'US';
----Q4
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME
FROM 
    Employee
WHERE 
    SALARY > (SELECT AVG(SALARY) FROM Employee);

------Q5
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.EMPLOYEE_ID,
    e.JOB_ID
FROM 
    Employee e
JOIN 
    Departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN 
    Locations l ON d.LOCATION_ID = l.location_id
WHERE 
    l.city = 'Toronto';

-----Q6
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.EMPLOYEE_ID,
    e.SALARY
FROM 
    Employee e
WHERE 
    e.MANAGER_ID = (SELECT EMPLOYEE_ID FROM Employee WHERE FIRST_NAME = 'Payam');
	select *from Employee;
-----Q7
SELECT 
    DEPARTMENT_NAME
FROM 
    Departments
WHERE 
    DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM Employee);
--select * from Employee;
select * from Departments;
----Q8
SELECT *
FROM
   Employee 
  EXCEPT
  SELECT *
FROM 
   Employee 
WHERE 
 MANAGER_ID IN (
 SELECT MANAGER_ID FROM Departments 
 WHERE 
 MANAGER_ID BETWEEN 100 AND 200);

   

---Q9
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.DEPARTMENT_ID
FROM 
    Employee e
WHERE 
    e.SALARY = (
        SELECT 
            MIN_SALARY
        FROM 
            Jobs j
        JOIN 
            Departments d ON j.JOB_ID = e.JOB_ID
        WHERE 
            d.DEPARTMENT_ID = e.DEPARTMENT_ID
    );
	select * from Employee

---Q10
SELECT 
    FIRST_NAME,
    LAST_NAME
FROM 
    Employee
WHERE 
    EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM Employee WHERE MANAGER_ID IS NOT NULL);

	--Q11
	SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    JOB_ID
FROM 
    Employee
WHERE 
    SALARY < (SELECT MIN_SALARY FROM Jobs WHERE JOB_ID = 'MK_MAN')
    AND JOB_ID != 'MK_MAN';

---Q12
SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM 
    Employee
WHERE 
    SALARY > (SELECT AVG(SALARY) FROM Employee);

-----Q13
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
FROM 
    Employee e
JOIN 
    Jobs j ON e.JOB_ID = j.JOB_ID
WHERE 
    e.SALARY = j.MIN_SALARY;

------Q14
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
	
FROM 
    Employee e
JOIN 
    Departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
 
    AND e.SALARY > (
        SELECT AVG(SALARY) 
        FROM Employee 
        WHERE 
		 d.DEPARTMENT_NAME = 'IT' 
    );
---Q15
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
FROM 
    Employee e

WHERE 
    e.SALARY >
	(select SALARY FROM Employee where LAST_NAME = 'Bell');


	---Q16
	SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
FROM 
    Employee e
WHERE 
    e.SALARY = (
        SELECT MIN(SALARY) 
        FROM Employee
    );

---Q17
SELECT 
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
FROM 
    Employee e
WHERE 
    e.SALARY > all(
        SELECT AVG(SALARY) 
        FROM Employee
		GROUP BY JOB_ID
    );
---Q18 3RD HIGHEST SALARY

SELECT MAX(SALARY) AS Third_Max_Salary
FROM Employee
WHERE SALARY <> (
    SELECT MAX(SALARY)
    FROM Employee
	WHERE SALARY <> (SELECT MAX(SALARY)
    FROM Employee
))
AND SALARY NOT IN (
    SELECT MAX(SALARY)
    FROM Employee
);

