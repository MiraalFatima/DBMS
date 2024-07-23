-----------------------QUESTION 4--------
--------POST LAB TRIGGERS-------------

CREATE TRIGGER CheckFeeCharges
ON Registration
FOR INSERT
AS
BEGIN
    DECLARE @RollNumber VARCHAR(7)
    DECLARE @TotalDues INT

    SELECT @RollNumber = i.RollNumber, @TotalDues = cf.TotalDues
    FROM inserted i
    INNER JOIN ChallanForm cf ON i.RollNumber = cf.RollNumber

    IF (@TotalDues > 20000)
    BEGIN
        RAISERROR ('Student cannot be enrolled with more than 20,000 fee charges due', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
----------------Q5----------------
CREATE TRIGGER PreventCourseDeletion
ON Courses_Semester
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE AvailableSeats < 10)
    BEGIN
        PRINT 'Not possible'
    END
    ELSE
    BEGIN
        DELETE FROM Courses_Semester WHERE EXISTS (SELECT * FROM deleted WHERE Courses_Semester.CourseID = deleted.CourseID AND Courses_Semester.Semester = deleted.Semester)
        PRINT 'Successfully deleted'
    END
END;
---------------Q6------------
CREATE TRIGGER PreventInstructorModification
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Instructors')
    BEGIN
        PRINT 'Instructors table cannot be modified or dropped'
        ROLLBACK
    END
END;