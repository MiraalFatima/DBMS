
--------------TRIGGERSSS------------
---------------Q1------------------

CREATE TRIGGER PreventDeleteStudent
ON Students
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'You don''t have the permission to delete the student'
END
---------------Q2------------------
CREATE TRIGGER PreventInsertCourse
ON Courses
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'You don''t have the permission to insert a new Course'
END
---------------Q3------------------
CREATE TABLE Notify (
    NotificationID int PRIMARY KEY,
    StudentID varchar(7),
    NotificationString varchar(100)
);

CREATE TRIGGER NotifyStudentRegistration
ON Registration
AFTER INSERT
AS
BEGIN
    DECLARE @NotificationID int, @StudentID varchar(7), @NotificationString varchar(100)

    SELECT @StudentID = i.RollNumber,
           @NotificationString = CASE WHEN i.GPA >= 2.0 THEN 'Your registration for CourseID ' + CAST(i.CourseID AS varchar(10)) + ' was successful.'
                                       ELSE 'Your registration for CourseID ' + CAST(i.CourseID AS varchar(10)) + ' was not successful due to low GPA.'
                                  END
    FROM inserted i

    -- Insert into Notify table
    INSERT INTO Notify (NotificationID, StudentID, NotificationString)
    VALUES (@@IDENTITY, @StudentID, @NotificationString)
END;

