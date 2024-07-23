-----------------QUESTION - 01------------------------
-- Drop the existing Auditing table if it exists
IF OBJECT_ID('Auditing', 'U') IS NOT NULL
    DROP TABLE Auditing;
GO

-- Recreate the Auditing table with DATETIME data type for last_change_on
CREATE TABLE Auditing (
    audit_id INT PRIMARY KEY,
    table_name VARCHAR(100),
    last_change_on DATETIME DEFAULT CURRENT_TIMESTAMP
);
GO

-- Create the trigger for Student table
CREATE TRIGGER student_audit_trigger ON Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO Auditing (table_name) VALUES ('Student');
END;
GO

-- Create the trigger for Department table
CREATE TRIGGER department_audit_trigger ON Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO Auditing (table_name) VALUES ('Department');
END;
GO

-- Create the trigger for Faculty table
CREATE TRIGGER faculty_audit_trigger ON Faculty
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO Auditing (table_name) VALUES ('Faculty');
END;
GO
-----------------QUESTION - 02------------------------
-- Drop the existing Auditing table if it exists
IF OBJECT_ID('Auditing', 'U') IS NOT NULL
    DROP TABLE Auditing;
GO

-- Recreate the Auditing table with DATETIME data type for last_change_on
CREATE TABLE Auditing (
    audit_id INT PRIMARY KEY,
    table_name VARCHAR(100),
    change_description VARCHAR(100),
    last_change_on DATETIME DEFAULT CURRENT_TIMESTAMP
);
GO

CREATE OR ALTER TRIGGER student_audit_trigger ON Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @change_desc VARCHAR(100);
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @change_desc = 'Student record inserted/updated/deleted';
    END
    ELSE
    BEGIN
        SET @change_desc = 'Student record deleted';
    END
    
    INSERT INTO Auditing (table_name, change_description) VALUES ('Student', @change_desc);
END;
GO

CREATE OR ALTER TRIGGER department_audit_trigger ON Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @change_desc VARCHAR(100);
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @change_desc = 'Department record inserted/updated/deleted';
    END
    ELSE
    BEGIN
        SET @change_desc = 'Department record deleted';
    END
    
    INSERT INTO Auditing (table_name, change_description) VALUES ('Department', @change_desc);
END;
GO

CREATE OR ALTER TRIGGER faculty_audit_trigger ON Faculty
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @change_desc VARCHAR(100);
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @change_desc = 'Faculty record inserted/updated/deleted';
    END
    ELSE
    BEGIN
        SET @change_desc = 'Faculty record deleted';
    END
    
    INSERT INTO Auditing (table_name, change_description) VALUES ('Faculty', @change_desc);
END;
GO
-----------------QUESTION - 03------------------------

CREATE VIEW EnrollmentView AS
SELECT 
    S.section_id,
    S.course_id,
    C.name AS course_name,
    C.credit_hrs,
    S.capacity,
    COUNT(E.student_roll_no) AS enrolled_students,
    (S.capacity - COUNT(E.student_roll_no)) AS available_seats
FROM 
    Section S
JOIN 
    Course C ON S.course_id = C.course_id
LEFT JOIN 
    Enrolled E ON S.section_id = E.section_id
GROUP BY 
    S.section_id, S.course_id, C.name, C.credit_hrs, S.capacity;

---an example query a student might use to see available sections:
SELECT * FROM EnrollmentView WHERE available_seats > 0;

-----------------QUESTION - 04------------------------

CREATE PROCEDURE GetAvailableSections
AS
BEGIN
    SET NOCOUNT ON;

    -- Your select statement to retrieve available sections from the view
    SELECT * FROM EnrollmentView WHERE available_seats > 0;
END;
--how you can execute the stored procedure:
EXEC GetAvailableSections;
-----------------QUESTION - 05------------------------
CREATE OR ALTER TRIGGER prevent_department_change_trigger
ON Department
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    -- Rollback the transaction and display an error message
    ROLLBACK TRANSACTION;
    RAISERROR('Cannot insert, update, or delete department information. Department information is immutable.', 16, 1);
END;

-----------------QUESTION - 06------------------------

CREATE OR ALTER TRIGGER prevent_alter_drop_trigger
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EventData XML;
    SET @EventData = EVENTDATA();

    IF @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(max)') = 'DROP_TABLE'
    BEGIN
        ROLLBACK;
    END
    ELSE IF @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(max)') = 'ALTER_TABLE'
    BEGIN
        ROLLBACK;
    END
END;

