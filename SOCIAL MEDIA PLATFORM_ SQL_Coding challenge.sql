-- Project Name-SOCIAL MEDIA PLATFORM --
/* -----------------------------------------------------------
---Today's challenge-KEYS, CONSTRAINTS, INSERT/UPDATE/DELETE---

-----Challenge 1 — Posts Table with Constraints-------
Create a posts table:
Column -Type  -Constraint
post_id-INT- PK, auto_increment
user_id- INT -FK → users.user_id
caption-TEXT
posted_at-DATETIME ->DEFAULT CURRENT-TIMESTAMP 
----------------------------------------------------------------*/
create database if not exists SOCIAL_MEDIA_db;
use SOCIAL_MEDIA_db;
create table if not exists users(user_id int primary key auto_increment,
								 user_name varchar(100) not null,
                                 email_id varchar(100) unique
);
create table if not exists Posts (post_id int primary key auto_increment,
								  user_id int,
                                  caption text,
                                  posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
								  FOREIGN KEY (user_id) REFERENCES users(user_id)							
);
/*--------------------------------------------- 
Challenge 2 – Followers Table
Create a followers table:
Column-Type-->Constraint
follower_id-INT-->FK → users.user_id
following_id-INT-->FK → users.user_id
follow_date-DATETIME-->DEFAULT CURRENT_TIMESTAMP 
------------------------------------------------------*/
create table if not exists Followers (follower_id int,
									  following_id int,
                                      follow_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      FOREIGN KEY (follower_id) REFERENCES users(user_id),
                                      FOREIGN KEY (following_id) REFERENCES users(user_id)																
);

/*------------------------------------
Challenge 3 – Insert Sample Data
Insert 5 users and 5 posts.
-------------------------------------*/

INSERT INTO users (user_name, email_id) VALUES
('Alex Rivera', 'alex.rivera@email.com'),
('Sarah Chen', 'sarah.c@techmail.org'),
('Jordan Smith', 'jsmith_data@webmail.net'),
('Elena Rodriguez', 'elena.rod@gmail.com'),
('Marcus Thorne', 'm.thorne@hotmail.com'),
('Priya Kapoor', 'priya.k@yahoo.com'),
('Liam Wilson', 'liam.w@gmail.com'),
('Chloe Dubois', 'chloe.d@hotmail.com'),
('Omar Hassan', 'omar.h@yahoo.com'),
('Sofia Rossi', 'sofia.rossi@gmail.com');

INSERT INTO Posts (user_id, caption, posted_at) VALUES
(1, 'Just finished my first SQL project! 🚀', '2026-03-01 09:00:00'),
(2, 'Coffee and code: the perfect morning ritual.', '2026-03-05 08:30:45'),
(3, 'Does anyone know the difference between JOIN and UNION? 🧐', '2026-03-10 14:20:00'),
(4, 'The sunset at the beach today was incredible! 🌅', '2026-03-12 18:45:10'),
(5, 'Exploring the new Power BI update. Some great features here.', '2026-03-15 11:15:00'),
(6, 'Data cleaning is 80% of the job, but it is so satisfying.', '2026-03-18 13:05:22'),
(1, 'Update: My SQL query finally ran without errors! Checkmark ✅', '2026-03-20 16:40:00'),
(8, 'Bonjour from Paris! Exploring the local libraries today.', '2026-03-22 10:10:05'),
(9, 'Always be curious. That is the secret to great analysis.', '2026-03-24 09:55:30'),
(10, 'Testing out the new auto-increment feature in my DB.', '2026-03-26 12:00:00');

UPDATE Posts
SET posted_at = CASE 
    WHEN post_id = 1  THEN '2024-03-15 09:00:00'
    WHEN post_id = 2  THEN '2024-06-20 08:30:45'
    WHEN post_id = 3  THEN '2024-11-12 14:20:00'
    WHEN post_id = 4  THEN '2025-01-05 18:45:10'
    WHEN post_id = 5  THEN '2025-02-14 11:15:00'
    WHEN post_id = 6  THEN '2025-03-01 13:05:22'
    WHEN post_id = 7  THEN '2025-03-10 16:40:00'
    WHEN post_id = 8  THEN '2024-08-22 10:10:05'
    WHEN post_id = 9  THEN '2025-03-20 09:55:30'
    WHEN post_id = 10 THEN '2025-03-25 12:00:00'
    ELSE posted_at 
END
WHERE post_id BETWEEN 1 AND 10;

INSERT INTO Followers (follower_id, following_id, follow_date) VALUES
(1, 2, '2024-05-10 10:30:00'), -- Alex follows Sarah
(1, 3, '2024-05-12 15:45:00'), -- Alex follows Jordan
(2, 1, '2024-06-01 09:00:00'), -- Sarah follows Alex (Mutual!)
(3, 1, '2024-07-20 11:20:00'), -- Jordan follows Alex
(4, 1, '2024-08-05 14:10:00'), -- Elena follows Alex
(5, 1, '2024-09-12 16:30:00'), -- Marcus follows Alex
(6, 2, '2025-01-10 08:45:00'), -- Priya follows Sarah
(7, 2, '2025-02-14 12:00:00'), -- Liam follows Sarah
(8, 9, '2025-03-01 13:15:00'), -- Chloe follows Omar
(10, 1, '2025-03-25 17:50:00'); -- Sofia follows Alex


-- DISTINCT, WHERE, IN, BETWEEN, NULL checks ----
/*------------------------------------------------
Challenge 1 — Filter Users
Retrieve all users whose username starts with “a”.
---------------------------------------------------*/

select * from users where  user_name like 'a%';

/*-----------------------------------------------------
Challenge 2 — Posts Filter
Get posts posted BETWEEN '2024-01-01' AND '2024-12-31'.
--------------------------------------------------------*/

select * from posts where posted_at BETWEEN '2024-01-01' AND '2024-12-31';

/*------------------------------------------
Challenge 3 — NULL checks
Find posts that have NULL captions.
--------------------------------------------*/

select * from posts where caption is null;

/*--------------------------------------------
Challenge 4 — IN Clause
Find users whose email domain is in:
(@gmail.com, @hotmail.com, @yahoo.com)
------------------------------------------ */

select * from users 
WHERE SUBSTRING_INDEX(email_id, '@', -1) IN ('gmail.com', 'hotmail.com', 'yahoo.com');

--- ORDER BY, GROUP BY, LIMIT, HAVING ----
/*------------------------------------------------
Challenge 1 — Top Active Users
Sort users by number of posts (DESC) and LIMIT 5
---------------------------------------------------*/

select u.user_id, u.user_name, count(p.post_id) as Total_posts from users u
join posts p on u.user_id = p.user_id
group by u.user_id, u.user_name
order by Total_posts desc
limit 5;

/*-------------------------------------------------
--Challenge 2 — Group by Posts Per Day---
Group posts by DATE(posted_at) and return:
date
total posts
Only show days with more than 10 posts (HAVING).
---------------------------------------------------*/

select date(posted_at) as post_date, count(post_id) as Total_posts from posts
group by date(posted_at)
Having Total_posts > 10
order by Total_posts desc;

--- JOINS, UNION, BUILT-IN FUNCTIONS ----

create table if not exists comments (comment_id int primary key auto_increment,
									 post_id int,									
									 user_id int,
								     comment text,
									 commented_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                     FOREIGN KEY (post_id) REFERENCES posts(post_id),
                                     FOREIGN KEY (user_id) REFERENCES users(user_id)
);
create table if not exists likes (like_id int auto_increment primary key,
								  post_id int,
                                  user_id int,
                                  liked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                  FOREIGN KEY (post_id) REFERENCES posts(post_id),
								  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO comments (post_id, user_id, comment, commented_at) VALUES
(1, 2, 'Great work on the project! SQL is a superpower.', '2024-03-16 10:00:00'),
(1, 3, 'Congrats! What resources did you use to learn?', '2024-03-17 14:30:00'),
(2, 1, 'Nothing beats a morning coffee and some clean code.', '2024-06-21 09:15:00'),
(3, 5, 'Think of JOIN as combining tables side-by-side, UNION as stacking them!', '2024-11-13 16:00:00'),
(5, 6, 'The Power BI update is a game changer for DAX.', '2025-02-15 12:45:00'),
(6, 4, 'So true! Cleaning the data is where the real insights start.', '2025-03-02 09:30:00'),
(7, 9, 'That checkmark feeling is the best. Well done!', '2025-03-11 18:20:00'),
(8, 10, 'Paris is beautiful! Enjoy the libraries.', '2024-08-23 11:10:00'),
(9, 2, 'Curiosity is definitely the fuel for data analysts.', '2025-03-21 10:00:00'),
(10, 1, 'The auto-increment feature saves so much manual work!', '2025-03-26 08:00:00');

INSERT INTO likes (post_id, user_id, liked_at) VALUES
(1, 4, '2024-03-15 12:00:00'),
(1, 5, '2024-03-15 15:30:00'),
(2, 3, '2024-06-20 10:45:00'),
(4, 7, '2025-01-06 07:20:00'),
(5, 8, '2025-02-14 14:10:00'),
(6, 1, '2025-03-01 15:55:00'),
(7, 2, '2025-03-10 17:00:00'),
(9, 3, '2025-03-20 11:30:00'),
(10, 4, '2025-03-25 13:45:00'),
(10, 5, '2025-03-25 14:00:00');

/*-------------------------------------------------------------------
--Challenge 2 — JOIN Report--
Display:
post_id, username, caption, total likes, total comments.
----------------------------------------------------------------------*/

select p.post_id, u.user_name, p.caption,
count( distinct(l.like_id)) as Total_likes,
count(distinct(c.comment_id)) as Total_comments from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by p.post_id, u.user_name, p.caption;

/*
-- Challenge 3 — Built-in Functions---
Show usernames in UPPER case.
Extract month name from posted_at.
Return the length of each caption.
------------------------------------------------------------------*/

select upper(user_name) from users;
select monthname(posted_at) from posts;
select caption, length(caption) from posts;

/*------------------------------------------------
Challenge 4 — UNION
Combine list of users who commented OR liked.
----------------------------------------------------*/

select user_id from comments
union
select user_id from likes;

select user_id, user_name from users
where user_id in (select user_id from comments
union
select user_id from likes);


-- FUNCTIONS, SUBQUERIES, STORED PROCEDURES--

/*--------------------------------------------------------
--Challenge 1 — User Defined Function--
Create a function:
GetUserEngagement(user_id)
Returns total likes + comments made by the user.
---------------------------------------------------------*/
select * from likes;
select * from comments;
select count(like_id) as Total_likes from likes where user_id =4;
select count(comment_id) as Total_comments from comments where user_id =2;

Delimiter //
create function GetUserEngagement(p_user_id int)
Returns int
Reads SQL data
Begin
	declare Total_likes int;
    declare Total_comments int;
    declare Grand_total int;
    select count(like_id) into Total_likes from likes where user_id = p_user_id;
    select count(comment_id) into Total_comments from comments where user_id = p_user_id;
	set Grand_total = Total_likes + Total_comments;
    Return Grand_total;
End //
Delimiter ;

select * , GetUserEngagement(user_id) as Total_engagement from users;

/*------------------------------------------------------------------
Challenge 2 — Subquery
Find users who have more followers than the average follower count.
---------------------------------------------------------------------*/

SELECT 
    u.user_id, 
    u.user_name, 
    COUNT(f.follower_id) AS total_followers
FROM users u
JOIN Followers f ON u.user_id = f.following_id
GROUP BY u.user_id, u.user_name
HAVING COUNT(f.follower_id) > (
    SELECT AVG(follower_count) 
    FROM (
        SELECT COUNT(follower_id) AS follower_count 
        FROM Followers 
        GROUP BY following_id
    ) AS average_table
);

/*
Challenge 3 — Stored Procedure
Stored procedure to retrieve all posts for a given username.
-----------------------------------------------------------------------*/

DELIMITER //

CREATE PROCEDURE GetPostsByUsername(IN target_username VARCHAR(100))
BEGIN
    SELECT 
        u.user_name, 
        p.post_id, 
        p.caption, 
        p.posted_at
    FROM users u
    JOIN posts p ON u.user_id = p.user_id
    WHERE u.user_name = target_username
    ORDER BY p.posted_at DESC;
END //

DELIMITER ;

call GetPostsByUsername('Alex Rivera');

-- VIEWS & TRIGGERS---

/*---------------------------------------
--Challenge 1 — View--
Create a view post_summary showing:
post_id
username
caption
total likes
total comments
---------------------------------------*/

create or replace view post_summary as 
select p.post_id, u.user_name, p.caption, count(distinct l.like_id) as total_likes, count(distinct c.comment_id) as total_comments
from posts p
left join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by p.post_id, u.user_name, p.caption;

select * from post_summary;

/*---------------------------------------------------------
--Challenge 2 — Trigger--
Trigger on likes table:
When a user likes a post, insert a row into a new table:
notifications (user_id, message, created_at) 
------------------------------------------------------------*/

CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT, -- The person receiving the notification
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO notifications (user_id, message, created_at) VALUES
(1, 'User 2 liked your post on SQL Joins.', '2025-03-20 10:00:00'),
(2, 'User 3 commented: "Great explanation!" on your photo.', '2025-03-22 14:30:00'),
(1, 'User 4 started following you.', '2025-03-24 09:15:00'),
(5, 'User 1 liked your comment on the Online Store project.', '2026-01-10 16:45:00'),
(3, 'User 2 started following you.', '2026-03-27 12:00:00');

DELIMITER //

CREATE TRIGGER After_User_Likes
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    DECLARE post_owner_id INT;
    SELECT user_id INTO post_owner_id 
    FROM posts 
    WHERE post_id = NEW.post_id;
    INSERT INTO notifications (user_id, message)
    VALUES (post_owner_id, CONCAT('User ', NEW.user_id, ' liked your post (ID: ', NEW.post_id, ')'));
END //

DELIMITER ;

-- Top influencers (users with highest total engagement)--

select * , GetUserEngagement(user_id) as total_engagement from users
order by total_engagement desc
limit 5;

-- Virality report (posts with unusually high engagement) --

SELECT 
    post_id, 
    user_name, 
    caption, 
    (total_likes + total_comments) AS engagement_score
FROM post_summary
WHERE (total_likes + total_comments) > (
    SELECT AVG(total_likes + total_comments) * 3
    FROM post_summary
)
ORDER BY engagement_score DESC;

-- User activity timeline (daily/weekly posting patterns) --

SELECT 
    DAYNAME(posted_at) AS day_of_week, 
    COUNT(*) AS total_posts
FROM posts
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Follower growth (who gained the most followers recently) --
SELECT 
	u.user_id,
    u.user_name, 
    COUNT(f.follower_id) AS new_followers_this_week
FROM users u
JOIN Followers f ON u.user_id = f.following_id
WHERE f.follow_date >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
GROUP BY u.user_id, u.user_name
ORDER BY new_followers_this_week DESC;

-- Trending hashtags (most used hashtags in last 30 days) --

CREATE TABLE IF NOT EXISTS hashtags (
    tag_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(50) UNIQUE
);

CREATE TABLE IF NOT EXISTS post_hashtags (
    post_id INT,
    tag_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (tag_id) REFERENCES hashtags(tag_id)
);

INSERT INTO hashtags (tag_name) VALUES 
('#SQLTips'), 
('#DataAnalytics'), 
('#CodingLife'), 
('#TechTrends2026'), 
('#DatabaseDesign'), 
('#WebDev'), 
('#OpenSource'), 
('#MachineLearning'), 
('#Innovation'), 
('#TravelTech');

INSERT INTO post_hashtags (post_id, tag_id) VALUES 
(1, 1),  -- Post 1 (First SQL project) -> #SQLTips
(1, 5),  -- Post 1 (First SQL project) -> #DatabaseDesign
(2, 3),  -- Post 2 (Coffee and code) -> #CodingLife
(3, 1),  -- Post 3 (JOIN vs UNION) -> #SQLTips
(5, 2),  -- Post 5 (Power BI update) -> #DataAnalytics
(6, 2),  -- Post 6 (Data cleaning) -> #DataAnalytics
(7, 5),  -- Post 7 (SQL query update) -> #DatabaseDesign
(8, 10), -- Post 8 (Paris libraries) -> #TravelTech
(9, 9),  -- Post 9 (Curious analysis) -> #Innovation
(10, 5), -- Post 10 (Auto-increment) -> #DatabaseDesign
(10, 4); -- Post 10 (Auto-increment) -> #TechTrends2026


SELECT 
    h.tag_name, 
    COUNT(ph.post_id) AS total_uses
FROM hashtags h
JOIN post_hashtags ph ON h.tag_id = ph.tag_id
JOIN posts p ON ph.post_id = p.post_id
WHERE p.posted_at >= DATE_SUB('2025-03-25', INTERVAL 30 DAY) -- Matching your 2025 data
GROUP BY h.tag_id, h.tag_name
ORDER BY total_uses DESC
LIMIT 5;





