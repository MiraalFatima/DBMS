

-- Standard deviation of ages, along with max and min age 
-- q1
SELECT 
    MAX(u.age) AS max_age,
    MIN(u.age) AS min_age,
    SQRT(AVG(age_diff_squared)) AS std_dev_age
FROM 
    users u,
    (SELECT POWER(age - (SELECT AVG(age) FROM users), 2) AS age_diff_squared FROM users) AS subquery;

	---q2 
	---highest followers 
SELECT 
    u.UserName, 
    COUNT(f.FollowedUserName) AS NumberOfFollowers
FROM 
    Users u
JOIN 
    Following f ON u.UserName = f.FollowedUserName
GROUP BY 
    u.UserName
HAVING 
    COUNT(f.FollowedUserName) = (
        SELECT MAX(FollowerCounts.NumberOfFollowers) 
        FROM (
            SELECT 
                FollowedUserName, 
                COUNT(FollowerUserName) AS NumberOfFollowers
            FROM 
                Following
            GROUP BY 
                FollowedUserName
        ) AS FollowerCounts
    )
ORDER BY 
    u.UserName;

--- q3
---Give name of the user who has second highest followers.
SELECT 
    UserName, 
    FollowerCount
FROM (
    SELECT 
        FollowedUserName AS UserName, 
        COUNT(FollowerUserName) AS FollowerCount
    FROM 
        Following
    GROUP BY 
        FollowedUserName
) AS UserFollowerCounts
WHERE 
    FollowerCount = (
        SELECT 
            MAX(FollowerCount) AS SecondHighestFollowerCount
        FROM (
            SELECT 
                COUNT(FollowerUserName) AS FollowerCount
            FROM 
                Following
            GROUP BY 
                FollowedUserName
        ) AS FollowerCounts
        WHERE 
            FollowerCount < (
                SELECT 
                    MAX(FollowerCount)
                FROM (
                    SELECT 
                        COUNT(FollowerUserName) AS FollowerCount
                    FROM 
                        Following
                    GROUP BY 
                        FollowedUserName
                ) AS AllFollowerCounts
            )
    );
	--q4
	--List names of all the users who have never tweeted.
	SELECT 
    u.UserName
FROM 
    Users u
 left 
 JOIN 
    Tweets t ON u.UserName = t.UserName
WHERE 
    t.TweetID IS NULL;

	---q5
	---List all the hashtags and usernames and number of times that user used that hashtag.
	SELECT
    u.UserName,
    h.Hashtag,
    COUNT(*) AS NumberOfTimesUsed
FROM
    Users u
JOIN
    Tweets t ON u.UserName = t.UserName
JOIN
    Hashtags h ON t.Text LIKE '%' + h.Hashtag + '%'
GROUP BY
    u.UserName, h.Hashtag
ORDER BY
    u.UserName, NumberOfTimesUsed DESC;

	---q6
	---- find users who have never used the hashtag #Census,
	SELECT DISTINCT u.UserName
FROM Users u
LEFT JOIN Tweets t ON u.UserName = t.UserName AND t.Text LIKE '%#Census%'
WHERE t.TweetID IS NULL;
--check 66666

---	q7	
---List all the usernames that have never been followed. Using Set operation

SELECT UserName
FROM Users

EXCEPT

SELECT DISTINCT FollowedUserName
FROM Following;

---q8
------List all the usernames that have never been followed. Using EXIT CLAUSE

SELECT UserName
FROM Users U
WHERE NOT EXISTS (
    SELECT 1
    FROM Following F
    WHERE F.FollowedUserName = U.UserName
);

---Q9
 --most common interest
 SELECT TOP 1 InterestID, Description AS Most_Common_Interest, CountInterest
FROM (
    SELECT I.InterestID, I.Description, COUNT(*) AS CountInterest
    FROM Interests I
    JOIN UserInterests UI ON I.InterestID = UI.InterestID
    GROUP BY I.InterestID, I.Description
) AS InterestCounts
ORDER BY CountInterest DESC;
--- least common interest 
SELECT InterestID, Description AS Least_Common_Interest, CountInterest
FROM (
    SELECT I.InterestID, I.Description, COUNT(*) AS CountInterest
    FROM Interests I
    JOIN UserInterests UI ON I.InterestID = UI.InterestID
    GROUP BY I.InterestID, I.Description
) AS InterestCounts
WHERE CountInterest = (
    SELECT MIN(CountInterest)
    FROM (
        SELECT COUNT(*) AS CountInterest
        FROM Interests I
        JOIN UserInterests UI ON I.InterestID = UI.InterestID
        GROUP BY I.InterestID, I.Description
    ) AS SubQuery
);


---q10
----Show total tweets per country. The result should be in order of country name.
SELECT U.Country, COUNT(T.TweetID) AS Total_Tweets
FROM Users U
JOIN Tweets T ON U.UserName = T.UserName
GROUP BY U.Country
ORDER BY U.Country;


---q11
--List names of all the users whose number of tweets is more than average number of  tweets per user.
SELECT UserName, NumTweets
FROM (
    SELECT UserName, COUNT(TweetID) AS NumTweets
    FROM Tweets
    GROUP BY UserName
) AS UserTweetCounts
WHERE NumTweets > (
    SELECT AVG(NumTweets) AS AvgTweets
    FROM (
        SELECT COUNT(TweetID) AS NumTweets
        FROM Tweets
        GROUP BY UserName
    ) AS AvgPerUser
);
---q12
---Give the name of the users who have at least one follower from Pakistan.
SELECT DISTINCT FollowedUserName
FROM Following
WHERE FollowerUserName IN (
    SELECT UserName
    FROM Users
    WHERE Country = 'Pakistan'
);
 ---q13
 ---Show the interest ID and description of interest with the most number of users.
 SELECT TOP 1 InterestID, Description AS Most_Common_Interest, CountInterest
FROM (
    SELECT I.InterestID, I.Description, COUNT(*) AS CountInterest
    FROM Interests I
    JOIN UserInterests UI ON I.InterestID = UI.InterestID
    GROUP BY I.InterestID, I.Description
) AS InterestCounts
ORDER BY CountInterest DESC;

