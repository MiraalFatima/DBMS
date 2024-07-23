 create table Student
(RollNumber int not null  , Name nvarchar(50) not null  , Gender varchar(8) not null  , Phone int not null );
create table Attendence
(RollNumber int not null , Date date not null  , Status varchar(8) not null  , ClassVenue int not null );
create table ClassVenue
(ID int not null  , Building varchar(50) not null  , RoomNumber varchar(8) not null  , Teacher varchar(50) not null );
create table Teacher
(Name varchar(50) not null  , designation varchar(20) not null  , department varchar(30) not null  );
alter Table Student add constraint FK_C1 FOREIGN KEY(RollNumber) references Attendance(RollNumber)
alter Table Attendance add constraint FK_C2 FOREIGN KEY(ClassVenue) references ClassVenue(ID)
alter Table ClassVenue add constraint FK_C3 FOREIGN KEY(Teacher) references Teacher(Name)
alter Table Teacher add constraint u_1 UNIQUE(Name);
alter Table Student add constraint  c_1 check(Gender in('Male','Female'));
alter Table Attendance add constraint  c_2 check(Status in('A','P'));