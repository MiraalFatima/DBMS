--Q2 DELETE RECORD OF STUDENTS WORKING ON PROJECT 10

--adding project 10 in table
INSERT INTO Project_Name values
(10,'Subway Surfers',3, 'Mobile Application, C#, SFML','Description 010')
SELECT * FROM Project_Name;
--inserting values of team 10
INSERT INTO Student values
(22, 'ALi','Fatima',1,2,'Hashir','Wajahat'),(6666, 'Ibrahim','Khalid',3,4,'Sufi','Laraib')
SELECT * FROM Student;

--deleting the record
DELETE FROM Student
WHERE Project_Number = 10;
SELECT * FROM Student;
