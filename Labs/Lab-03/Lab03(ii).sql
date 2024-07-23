Create database ATMs
go 
use ATMs
go

create table [User]
(
userId int primary key identity(1,1),
name varchar(20) not null,
phoneNum varchar(15) not null,
city varchar(20) not null
);
ALTER TABLE [User] 
ADD CONSTRAINT uc_check1 CHECK (userId <= 5);

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
);

create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
);


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
);

create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
);


INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Hafeez', N'03036061000', N'Lahore')
GO
INSERT [dbo].[User] ( [name], [phoneNum], [city]) VALUES ( N'Haaafeez', N'03036061000', N'Lahore')

INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from Card
Select * from CardType
Select * from [Transaction]
--1 Find the total number of unique users of each cardType.
SELECT 
  ct.name AS CardType ,COUNT(Distinct uc.UserID) AS NumberOfUsers FROM CardType ct
  JOIN Card c on c.cardTypeID=ct.cardTypeID 
  JOIN UserCard uc on uc.cardNum=c.cardNum group by ct.name;

--2- Show the card numbers and user names whose balance is in the range (Min: 2000, Max: 4000).
SELECT c.CardNum AS CardNumber,u.name AS NameOfUser 
From [User] u
Join 
UserCard uc on uc.userID = u.UserID 
JOin Card c on c.cardNum=uc.cardNum  where c.balance>20000 AND c.balance <40000;

--3- Show the name of those users who do not possess any card.
--(a)
SELECT u.name AS Name FROM [User] u  
EXCEPT 
select u.name From [User] u Join UserCard uc on u.userId=uc.userID;
--(b)
SELECT u.name FROM [User] u LEFT JOIN UserCard uc ON u.userId = uc.userID
WHERE uc.userID IS NULL;

--4-Show the id of those cards along with the card type name and the owner’s name for which no transaction has been carried out in the last year. (Do not hardcode the year as 2018. To get current year you can use year (getdate() ) ).
--(a)
SELECT c.cardNum, ct.name AS CardTypeName, u.name AS OwnerName
FROM [Card] c
JOIN [CardType] ct ON c.cardTypeID = ct.cardTypeID
JOIN [UserCard] uc ON c.cardNum = uc.cardNum
JOIN [User] u ON uc.userID = u.userId
EXCEPT
SELECT c.cardNum, ct.name AS CardTypeName, u.name AS OwnerName
FROM [Card] c
JOIN [Transaction] t ON c.cardNum = t.cardNum
JOIN [CardType] ct ON c.cardTypeID = ct.cardTypeID
JOIN [UserCard] uc ON c.cardNum = uc.cardNum
JOIN [User] u ON uc.userID = u.userId
WHERE YEAR(t.transDate) = YEAR(GETDATE()) - 1;

--(b)
SELECT c.cardNum, ct.name AS CardTypeName, u.name AS OwnerName
FROM [Card] c
JOIN [CardType] ct ON c.cardTypeID = ct.cardTypeID
JOIN [UserCard] uc ON c.cardNum = uc.cardNum
JOIN [User] u ON uc.userID = u.userId
LEFT JOIN [Transaction] t ON c.cardNum = t.cardNum AND YEAR(t.transDate) = YEAR(GETDATE()) - 1
WHERE t.transID IS NULL;
--5-For each card type, show the total number of cards whose total sum of transaction amount is greater than 6000. Consider only the transactions carried out in the period 2015-2017.

SELECT ct.name AS CardType, COUNT(DISTINCT c.cardNum) AS TotalCards
FROM CardType ct
JOIN Card c ON ct.cardTypeID = c.cardTypeID
JOIN [Transaction] t ON c.cardNum = t.cardNum
WHERE YEAR(t.transDate) BETWEEN 2015 AND 2017
GROUP BY ct.name
HAVING SUM(t.amount) > 2000;

SELECT ct.name AS CardType, COUNT(*) AS NumberOfCards FROM CardType ct
JOIN 
    Card c ON ct.cardTypeID = c.cardTypeID
JOIN 
    UserCard uc ON c.cardNum = uc.cardNum
JOIN 
    [Transaction] t ON c.cardNum = t.cardNum
WHERE t.transDate BETWEEN '2015-01-01' AND '2016-12-31'
GROUP BY ct.name HAVING  SUM(t.amount) > 1000;

--6-List the user id, name, phone number, city of those users whose card is expiring within the next 3 months. Also show the card number along with card type name.

	SELECT u.UserID, u.name,u.PhoneNum,u.City,c.CardNum,ct.name AS CardTypeName FROM [User] u
JOIN 
    UserCard uc ON u.userId = uc.userID
JOIN 
    Card c ON uc.cardNum = c.cardNum
JOIN 
    CardType ct ON c.cardTypeID = ct.cardTypeID
WHERE c.expireDate <= DATEADD(MONTH, 3, GETDATE());

--7-Show the user id and name of those users whose total balance is equal to or greater than 5000.It is possible that a user has more than 1 card. In such a case, you will have to take sum of balance of each card of the user.
SELECT  u.userId, u.name FROM  [User] u
JOIN 
    UserCard uc ON u.userId = uc.userID
JOIN 
    (
        SELECT 
            uc.userID,
            SUM(c.balance) AS total_balance
        FROM 
            [UserCard] uc
        JOIN 
            [Card] c ON uc.cardNum = c.cardNum
        GROUP BY 
            uc.userID
    ) AS user_card_balances ON u.userId = user_card_balances.userID
WHERE 
    user_card_balances.total_balance >= 5000;
--8-Show those card pairs which are expiring in the same year.

	SELECT c1.cardNum AS CardNum1, c2.cardNum AS CardNum2,
	YEAR(c1.expireDate) AS ExpireYear FROM CARD c1 inner join Card c2 ON c1.expireDate < c2.expireDate 
	WHERE YEAR(c1.expireDate) = YEAR(c2.expireDate) AND c1.cardNum != c2.cardNum;
--9-Show those user pairs whose names’ first characters are the same.
SELECT 
    uA.userId AS USERID_1,
    uA.name AS NAME_1,
    uB.userId AS USERID_2,
    uB.name AS NAME_2
FROM  [User] uA JOIN  [User] uB ON LEFT(uA.name, 1) = LEFT(uB.name, 1) AND uA.userId < uB.userId; 

--10-Show the name and id of those users who possess both the credit card and the debit card.

Select u.name,u.userID FROM [User] u
JOIN 
    UserCard uc ON u.userID = uc.userID
JOIN 
    Card c ON uc.cardNum = c.cardNum
JOIN 
    CardType ct ON c.cardTypeID = ct.cardTypeID 
WHERE ct.name IN ('Credit', 'Debit') GROUP BY  u.userId, u.name HAVING  COUNT(DISTINCT ct.name) = 2

--11- Show the City name, number of users and the sum of amount of the users from same city.
	SELECT
    u.city AS CityName,
    COUNT(u.userId) AS NumOfUsers,
    SUM(t.amount) AS TotalAmount
FROM [User] u JOIN
  UserCard uc ON u.userId = uc.userID
JOIN
    [Card] c ON uc.cardNum = c.cardNum
JOIN
    [Transaction] t ON c.cardNum = t.cardNum
GROUP BY
    u.city;

