--Q4 

--(i)Find exam time and date of student user no: 1010 and Room_no = 005

--Following query will show empty columns as such data doesnot exist
SELECT ExamTime, ExamDay FROM Exam 
where Stud_User_No='1010' AND Room_No='005';

--Add 2 columns where student user no: 1010 and Room_no = 005
INSERT INTO Student values(1010,'Asna','Atif',2,NULL,'Insa','Rayyan');
INSERT INTO Exam values(1010,43,'10:00:00','Wednesday',005);
SELECT * FROM Exam;

--Following query will show 1 result
SELECT ExamTime, ExamDay FROM Exam 
where Stud_User_No='1010' AND Room_No='005';

--(ii) Show all project names in descending order
SELECT Project_Name FROM Project 
ORDER BY Project_Name DESC;

--(iii) Show fname of staff member with L_Name starting with A and ending with A.
SELECT F_Name FROM StaffMember 
WHERE L_Name LIKE 'a%a';

--(iv)Show name of student who has not been assigned any supervisor as yet.
SELECT F_Name, L_Name FROM Student
WHERE Super_No IS NULL;

--(v)Show user no who are sitting between room 005 and 009 during exam.
SELECT Stud_User_No FROM Exam
WHERE Room_No BETWEEN '5' AND '9';

--(vi)Show students name with its supervisor name and project number.
SELECT F_Name,L_Name, Proj_No, Super_No FROM Student;