create database LAB09

use  LAB09;


CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    batch INT
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    name VARCHAR(100),
    credit_hrs INT,
    dept_id INT
);

CREATE TABLE Section (
    section_id INT PRIMARY KEY,
    course_id INT,
    capacity INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Enrolled (
    student_roll_no INT,
    section_id INT,
    PRIMARY KEY (student_roll_no, section_id),
    FOREIGN KEY (student_roll_no) REFERENCES Student(roll_no),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT
);

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Inserting into Department table
INSERT INTO Department (dept_id, name) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering'),
(3, 'Mechanical Engineering');

-- Inserting into Course table
INSERT INTO Course (course_id, name, credit_hrs, dept_id) VALUES
(101, 'Introduction to Programming', 3, 1),
(102, 'Database Management', 3, 1),
(103, 'Electric Circuits', 3, 2),
(104, 'Thermodynamics', 3, 3);

-- Inserting into Student table
INSERT INTO Student (roll_no, name, dept_id, batch) VALUES
(1001, 'John Doe', 1, 2023),
(1002, 'Jane Smith', 1, 2024),
(1003, 'Michael Johnson', 2, 2022),
(1004, 'Emily Brown', 3, 2023);

-- Inserting into Section table
INSERT INTO Section (section_id, course_id, capacity) VALUES
(1, 101, 50),
(2, 102, 40),
(3, 103, 35),
(4, 104, 30);

-- Inserting into Faculty table
INSERT INTO Faculty (faculty_id, name, dept_id) VALUES
(2001, 'Dr. Ali Afzal', 1),
(2002, 'Prof. Zoha Waaheed', 2),
(2003, 'Dr. Hina Iqbal', 3);

-- Inserting into Enrolled table
INSERT INTO Enrolled (student_roll_no, section_id) VALUES
(1001, 1),
(1002, 1),
(1003, 3),
(1004, 4);

