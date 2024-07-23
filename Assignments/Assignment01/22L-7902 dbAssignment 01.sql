--CREATION AND POPULATION OF TABLES ALONG WITH NECESSARY CONSTRAINTS

create database DBMSAssignment01
use DBMSAssignment01

--FIRST TABLE--
create table StaffMember
( F_Name varchar(50), L_Name varchar(50), User_No int primary key
);
insert INTO StaffMember values('Fatima','Hira',001),('Miraal','FAtima',002),('Shanza','Rahman',003),('Ayesha','Tariq',004),('Shehzil','Sattar',005)
insert INTO StaffMember values ('Hadia','Akhtar',006);
select * from StaffMember;
alter table StaffMember
alter column F_Name varchar(50) NOT NUll;

--SECOND TABLE
create table Project_Name
(Project_NUmber int primary key, Project_Name varchar(80),  Project_difficulty_level int, Project_Keywords varchar(80), DescriptionDetails varchar(1000)
);
insert INTO  Project_Name values(001,'Turkish Draught', 2, 'Mobile Application, Game, Java, SQL, Android Studio , SFML', 'Description 001'),
(002,'E-Voting', 3, 'Web Application, C++, SQL, Android Studio , Kotlin', 'Description 002'),
(003,'Railway Management System',4, 'Desktop Application, C++, SFML','Description 003')
select * from Project_Name;

--THIRD TABLE
create table Student 
(User_Number int primary key, F_name varchar(50) NOT NULL, L_Name varchar(50), Project_Number int, Super_Number int, Assessor1 varchar(100), Assessor2 varchar(100));
select * from Student;
alter table Student 
add constraint FK_Proj_No FOREIGN KEY (Project_Number) references Project_Name (Project_Number);
 alter table Student
add constraint FK_Super_No FOREIGN KEY (Super_Number) references StaffMember (User_No);
insert into Student values(1234, 'Jackline','Fernendez',1,2,'Diana','Shakespear'),
(2345,'Miraal','Fatima',2,1,'Malaika','Ahmed'),
(3456,'Ahmed','Ali',3,2,'Hussnain','Ali');

--this will show if the relational integrity constraints have been successfully implemented
--INSERT INTO Student values (7933, 'Eman','Tauqeer', 5,1,'Irha','Abdullah'),
--(8375,'Ibrahim','Gul',3,5,'Rabbia','Iqra');
--SELECT * FROM Student;
--Once Corrected
INSERT INTO Student values (7933, 'Eman','Tauqeer', 2,1,'Irha','Abdullah'),
(8375,'Ibrahim','Gul',3,3,'Rabbia','Iqra');
SELECT * FROM Student;

--Q2 DELETE RECORD OF STUDENTS WORKING ON PROJECT 10

--adding project 10 in table
INSERT INTO Project_Name values
(10,'Subway Surfers', 3, 'Mobile Application, C#, SFML','Description 010')
SELECT * FROM Project_Name;
--inserting values of team 10
INSERT INTO Student values
(22, 'ALi','Fatima',1,2,'Hashir','Wajahat'),(6666, 'Ibrahim','Khalid',3,4,'Sufi','Laraib')
SELECT * FROM Student;

--deleting the record
DELETE FROM Student
WHERE Project_Number = 10;
SELECT * FROM Student;

--Fourth Table
create table Exams
(Student_User_No int, Exam_No int, ExamTime time, ExamDay varchar(50), Room_Number int
primary key (Student_User_No, Exam_No), foreign key (Student_User_No) references Student);

INSERT INTO Exams values (1234, 10, '08:30', 'Monday', 200),
(2345, 11, '10:30', 'Tuesday', 201),
(3456, 12, '13:00', 'Wednesday', 203)
SELECT * FROM Exams;

alter table Exams
add constraint time_check check (ExamTime >= '00:00' AND ExamTime <= '23:59');
alter table Exams
add constraint day_check CHECK (ExamDay IN ('Tuesday', 'Monday', 'Wednesday'));


--Change level from 4 to 5 where in the keyword column there is a presence of 'Android'
UPDATE	Project_Name
SET Project_difficulty_level = 5
WHERE Project_Keywords LIKE '%Android%';
SELECT * FROM Project_Name;


--Q4 

--Following query will show empty columns as such data doesnot exist
select ExamTime, ExamDay from Exams 
where Student_User_No='1010' AND Room_Number='005';

--Add 2 columns where student user no: 1010 and Room_no = 005
insert into Student values(1010,'shazia','Kaleem',2,NULL,'razi','ali');
insert into Exams values(1010,22,'10:00:00','Wednesday',05);
select * from Exams;


select ExamTime, ExamDay from Exams 
where Student_User_No='1010' AND Room_Number='005';

--(ii) 
select Project_Name from Project_Name 
order by Project_Name DESC;

--(iii)
select F_Name from StaffMember 
where L_Name LIKE 'a%a';

--(iv)
select F_Name, L_Name from Student
where Super_Number IS NULL;

--(v)
select Student_User_No from Exams
where Room_Number BETWEEN '5' AND '9';

--(vi)
select F_Name,L_Name, Project_Number, Super_Number from Student;