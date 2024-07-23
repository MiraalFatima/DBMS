 
use DBq1a23
go

create table [Suppliers](
[snum] nvarchar(2) primary key,
[sname] varchar(20) not null,
[status] int not null,
[city] varchar(20) not null
)
go

create table [Parts](
[pnum] nvarchar(2) primary key,
[pname] varchar(20) not null,
[color] varchar(15) not null,
[weight] int not null,
[city] varchar(20) not null
)
go
create Table [Job](
[jnum] nvarchar(2) primary key,
[jname] varchar(20) not null,
[numworkers] int not null,
[city] varchar(20) not null
)
go

create table [Shipments](

[snum] nvarchar(2) foreign key references [Suppliers](snum),
[pnum] nvarchar(2) foreign key references [Parts](pnum),
[jnum] nvarchar(2) foreign key references [Job](jnum),
[quantity] int not null

)


INSERT [dbo].[Suppliers] ([snum], [sname], [status], [city]) VALUES ('S1', 'Smith', 20, 'London')
GO
INSERT [dbo].[Suppliers] ([snum], [sname], [status], [city]) VALUES ('S2', 'Jones', 10, 'Paris')
GO
INSERT [dbo].[Suppliers] ([snum], [sname], [status], [city]) VALUES ('S3', 'Blake', 30, 'Paris')
GO
INSERT [dbo].[Suppliers] ([snum], [sname], [status], [city]) VALUES ('S4', 'Clark',20, 'London')
GO
INSERT [dbo].[Suppliers] ([snum], [sname], [status], [city]) VALUES ('S5', 'Adams',30, 'Athens')
GO


INSERT [dbo].[Parts] ([pnum], [pname], [color],[weight], [city]) VALUES ('P1', 'Nut', 'Red',30, 'London')
GO
INSERT [dbo].[Parts] ([pnum], [pname], [color],[weight], [city]) VALUES ('P2', 'Bolt', 'Green',10, 'Paris')
GO
INSERT [dbo].[Parts] ([pnum], [pname], [color],[weight], [city]) VALUES ('P3', 'Screw', 'Blue',20, 'Rome')
GO
INSERT [dbo].[Parts] ([pnum], [pname], [color],[weight], [city]) VALUES ('P4', 'Screw','Red',30, 'London')
GO
INSERT [dbo].[Parts] ([pnum], [pname], [color],[weight], [city]) VALUES ('P5', 'Cam','Blue', 10,'Paris')
GO
INSERT [dbo].[Parts] ([pnum], [pname], [color], [weight],[city]) VALUES ('P6', 'Cog','Red',20, 'London')
GO


INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J1', 'Sorter', 20, 'Paris')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J2', 'Punch', 10, 'Rome')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J3', 'Reader', 30 , 'Athens')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J4', 'Console',20, 'Athens')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J5', 'Collator',30, 'London')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J6', 'Terminal',20, 'Oslo')
GO
INSERT [dbo].[Job] ([jnum], [jname], [numworkers], [city]) VALUES ('J7', 'Tape',10, 'London')
GO


INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S1', 'P1','J1', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity])VALUES ('S1', 'P1','J4', 700)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J1', 400)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J2', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J3', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J4', 500)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J5', 600)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J6', 400)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P3','J7', 800)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S2', 'P5','J2', 100)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S3', 'P3','J1', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S3', 'P4','J2', 500)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S4', 'P6','J3', 300)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S4', 'P6','J7', 300)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P2','J2', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P2','J4', 100)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P5','J5', 500)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P5','J7', 100)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P6','J2', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P1','J4', 100)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P3','J4', 200)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P4','J4', 800)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P5','J4', 400)
GO
INSERT [dbo].[Shipments] ([snum], [pnum], [jnum], [quantity]) VALUES ('S5', 'P6','J4', 500)
GO




Select * from [Suppliers]
Select * from [Parts]
Select * from [Job]
Select * from [Shipments]


----Q1
SELECT DISTINCT pnum
FROM Shipments
GROUP BY pnum
HAVING COUNT(DISTINCT snum) > 1;

-----Q2
SELECT AVG(weight) AS average_weight
FROM Parts;

----Q3
SELECT p.pnum AS part_number, SUM(s.quantity) AS total_shipped
FROM Parts p
JOIN Shipments s ON p.pnum = s.pnum
GROUP BY p.pnum
ORDER BY total_shipped DESC;

----Q4
SELECT DISTINCT s.sname
FROM Suppliers s
JOIN Shipments sh ON s.snum = sh.snum
JOIN Parts p ON sh.pnum = p.pnum
WHERE p.weight > 200;
-----q5
SELECT DISTINCT s.city
FROM Suppliers s
JOIN Job j ON s.city = j.city;

----Q6
SELECT DISTINCT j.jname
FROM Shipments sh
JOIN Job j ON sh.jnum = j.jnum
WHERE sh.snum = 'S1';

---Q7
SELECT DISTINCT p.pname
FROM Parts p
LEFT JOIN Shipments sh ON p.pnum = sh.pnum
WHERE sh.jnum IS NULL;

---Q8
SELECT DISTINCT s.sname
FROM Suppliers s
INNER JOIN Shipments sh ON s.snum = sh.snum
WHERE sh.pnum = 'P2';

----Q9
SELECT DISTINCT s.sname
FROM Suppliers s
INNER JOIN Shipments sh ON s.snum = sh.snum
INNER JOIN Parts p ON sh.pnum = p.pnum
WHERE p.color = 'Red';


---Q10
SELECT p.pnum
FROM Parts p
INNER JOIN Shipments s ON p.pnum = s.pnum
GROUP BY p.pnum
HAVING COUNT(*) > 1;





