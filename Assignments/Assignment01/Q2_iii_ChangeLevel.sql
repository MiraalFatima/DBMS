-- Q3 CHANGE THE LEVEL OF PRJECT WITH ANDROID IN THEIR KEYWORDS


--Change level from 4 to 5 where in the keyword column there is a presence of 'Android'
UPDATE Project_difficulty_level
SET level = 5
WHERE keywords LIKE '%Android%';
SELECT * FROM Project_Name;
