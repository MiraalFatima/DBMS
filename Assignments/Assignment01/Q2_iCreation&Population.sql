--CREATION AND POPULATIOJN OF TABLES ALONG WITH NECESSARY CONSTRAINTS

create database DBAssignment01
use DBAssignment01

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
(Project_NUmber int primary key, Project_Name varchar(80),  Project_difficulty_level varchar(50), Project_Keywords varchar(80), DescriptionDetails varchar(1000)
);
insert INTO  Project_Name values(001,'Turkish Draught', 'easy', 'Mobile Application, Game, Java, SQL, Android Studio , SFML', 'Description 001'),
(002,'E-Voting', 'mid', 'Web Application, C++, SQL, Android Studio , Kotlin', 'Description 002'),
(003,'Railway Management System','diff' , 'Desktop Application, C++, SFML','Description 003')
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

--The following statement will not execute as day_check constraint is violated
--INSERT INTO Exams VALUES  (7902, 42, '19:00:00', 'Friday', 420)
--SELECT * FROM Exams;

--The following statement will not execute since the primary key constraint is violated
--INSERT INTO Exam VALUES  (6192, 41, '19:00:00', 'Thursday', 420);

--The following statement will not execute since the Relational Integrity constraint is violated.

--INSERT INTO Exam VALUES  (7978, 41, '19:00:00', 'Thursday', 420);


