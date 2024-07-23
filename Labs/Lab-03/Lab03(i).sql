 --q4
--A: USING SET OPERATIONS
SELECT c.cardNum, ct.name AS CardTypeName, u.name AS OwnerName
FROM Card c
JOIN CardType ct ON c.cardTypeID = ct.cardTypeID
JOIN UserCard uc ON c.cardNum = uc.cardNum
JOIN [User] u ON uc.userID = u.userId
WHERE NOT EXISTS (
    SELECT 1
    FROM [Transaction] t
    WHERE t.cardNum = c.cardNum
    AND YEAR(t.transDate) = YEAR(GETDATE()) - 1
);
--q5 
SELECT CardType,
    COUNT(*) AS TotalCards
FROM (SELECT 
        ct.name AS CardType,
        SUM(t.amount) AS TotalAmount
    FROM  CardType ct
    JOIN 
        Card c ON ct.cardTypeID = c.cardTypeID
    JOIN 
        [Transaction] t ON c.cardNum = t.cardNum
    WHERE YEAR(t.transDate) BETWEEN 2015 AND 2017
    GROUP BY  ct.name
) AS SubQuery
WHERE
    TotalAmount > 6000
GROUP BY 
    CardType;
--q6 m
SELECT 
    u.userId,
    u.name AS UserName,
    u.phoneNum,
    u.city,
    c.cardNum,
    ct.name AS CardTypeName
FROM 
    [User] u
JOIN 
    UserCard uc ON u.userId = uc.userID
JOIN 
    Card c ON uc.cardNum = c.cardNum
JOIN 
    CardType ct ON c.cardTypeID = ct.cardTypeID
WHERE 
    c.expireDate BETWEEN GETDATE() AND DATEADD(month, 3, GETDATE());

	--q7
	SELECT
    u.userId,
    u.name AS UserName
FROM
    [User] u
JOIN
    UserCard uc ON u.userId = uc.userID
JOIN
    Card c ON uc.cardNum = c.cardNum
GROUP BY
    u.userId,
    u.name
HAVING
    SUM(c.balance) >= 5000;

--q8
SELECT 
    c1.cardNum AS Card1,
    c2.cardNum AS Card2
FROM 
    Card c1
INNER JOIN 
    Card c2 ON c1.expireDate = c2.expireDate AND c1.cardNum < c2.cardNum;

--q9
SELECT 
    u1.userId AS UserId1,
    u1.name AS UserName1,
    u2.userId AS UserId2,
    u2.name AS UserName2
FROM 
    [User] u1
JOIN 
    [User] u2 ON LEFT(u1.name, 1) = LEFT(u2.name, 1) AND u1.userId < u2.userId;

	--q10
	SELECT 
    u.userId,
    u.name AS UserName
FROM 
    [User] u
JOIN 
    UserCard uc ON u.userId = uc.userID
JOIN 
    Card c ON uc.cardNum = c.cardNum
JOIN 
    CardType ct ON c.cardTypeID = ct.cardTypeID
WHERE 
    ct.name IN ('Credit', 'Debit')
GROUP BY 
    u.userId,
    u.name
HAVING 
    COUNT(DISTINCT ct.name) = 2;


	--q11
	SELECT 
    u.city AS CityName,
    COUNT(DISTINCT u.userId) AS NumberOfUsers,
    SUM(t.amount) AS TotalAmount
FROM 
    [User] u
JOIN 
    UserCard uc ON u.userId = uc.userID
JOIN 
    [Card] c ON uc.cardNum = c.cardNum
JOIN 
    [Transaction] t ON c.cardNum = t.cardNum
GROUP BY 
    u.city;

