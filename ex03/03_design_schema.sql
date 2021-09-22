--- CREATE TABLES ---
CREATE TABLE Users(
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  type ENUM('admin', 'normal') DEFAULT 'normal' NOT NULL;
);


CREATE TABLE Categories(
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(30) NOT NULL
);

CREATE TABLE Articles(
  article_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  content TEXT NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES Users(user_id),
  CONSTRAINT fk_category FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Comments(
  comment_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  article_id INT NOT NULL,
  comment TEXT NOT NULL,
  CONSTRAINT fk2_user FOREIGN KEY(user_id) REFERENCES Users(user_id),
  CONSTRAINT fk_article FOREIGN KEY(article_id) REFERENCES Articles(article_id)
);

--- SCHEMA ---
DESC Users;
/*
+---------+------------------------+------+-----+---------+----------------+
| Field   | Type                   | Null | Key | Default | Extra          |
+---------+------------------------+------+-----+---------+----------------+
| user_id | int                    | NO   | PRI | NULL    | auto_increment |
| name    | varchar(20)            | NO   |     | NULL    |                |
| type    | enum('admin','normal') | NO   |     | normal  |                |
+---------+------------------------+------+-----+---------+----------------+
*/

DESC Categories;
/*
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| category_id | int         | NO   | PRI | NULL    | auto_increment |
| type        | varchar(30) | NO   |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
*/

DESC Articles;
/*
+-------------+------+------+-----+---------+----------------+
| Field       | Type | Null | Key | Default | Extra          |
+-------------+------+------+-----+---------+----------------+
| article_id  | int  | NO   | PRI | NULL    | auto_increment |
| user_id     | int  | NO   | MUL | NULL    |                |
| category_id | int  | NO   | MUL | NULL    |                |
| content     | text | NO   |     | NULL    |                |
+-------------+------+------+-----+---------+----------------+
*/

DESC Comments;
/*
+------------+------+------+-----+---------+----------------+
| Field      | Type | Null | Key | Default | Extra          |
+------------+------+------+-----+---------+----------------+
| comment_id | int  | NO   | PRI | NULL    | auto_increment |
| user_id    | int  | NO   | MUL | NULL    |                |
| article_id | int  | NO   | MUL | NULL    |                |
| comment    | text | NO   |     | NULL    |                |
+------------+------+------+-----+---------+----------------+
*/


--- INSERT VALUES ---
INSERT INTO Users (name, type)
VALUES ('user1', 'admin'),
('user2', 'normal'),
('user3', 'normal'),
('user4', 'normal'),
('user5', 'normal'),
('user6', 'normal');


INSERT INTO Categories (type)
VALUES ('Programming'),
('databases'),
('General'),
('random');


INSERT INTO Articles (user_id, category_id, content)
VALUES (2, 2, '1st Article'),
(1, 3, 'Admin note'),
(2, 1, '2nd article'),
(2, 2, '3rd article'),
(3, 1, '4th article'),
(5, 2, '5th article'),
(5, 1, '6th article'),
(3, 4, '7th article'),
(5, 2, '8th article'),
(3, 4, '9th article');


INSERT INTO Comments (user_id, article_id, comment)
VALUES (5, 2, '1st comment'),
(3, 1, '2nd comment'),
(5, 2, '3rd comment'),
(1, 2, '4th comment'),
(3, 2, '5th comment'),
(1, 10, '6th comment'),
(3, 2, '7th comment'),
(6, 5, '8th comment');


--- UPDATE TABLE ---
UPDATE Users
SET type = 'admin'
WHERE user_id = 6;
/*
 before 
+---------+-------+--------+
| user_id | name  | type   |
+---------+-------+--------+
|       1 | user1 | admin  |
|       2 | user2 | normal |
|       3 | user3 | normal |
|       4 | user4 | normal |
|       5 | user5 | normal |
|       6 | user6 | normal |
+---------+-------+--------+

after
+---------+-------+--------+
| user_id | name  | type   |
+---------+-------+--------+
|       1 | user1 | admin  |
|       2 | user2 | normal |
|       3 | user3 | normal |
|       4 | user4 | normal |
|       5 | user5 | normal |
|       6 | user6 | admin  |
+---------+-------+--------+
*/

UPDATE Categories
SET type = 'Guidelines'
WHERE category_id = 3;
/*
 before 
+-------------+-------------+
| category_id | type        |
+-------------+-------------+
|           1 | Programming |
|           2 | databases   |
|           3 | General     |
|           4 | random      |
+-------------+-------------+

after
+-------------+-------------+
| category_id | type        |
+-------------+-------------+
|           1 | Programming |
|           2 | databases   |
|           3 | Guidelines  |
|           4 | random      |
+-------------+-------------+
*/

--- DELETE ---
DELETE FROM Comments 
WHERE comment_id = 5;
/*
Before
+------------+---------+------------+-------------+
| comment_id | user_id | article_id | comment     |
+------------+---------+------------+-------------+
|          1 |       5 |          2 | 1st comment |
|          2 |       3 |          1 | 2nd comment |
|          3 |       5 |          2 | 3rd comment |
|          4 |       1 |          2 | 4th comment |
|          5 |       3 |          2 | 5th comment |
|          6 |       1 |         10 | 6th comment |
|          7 |       3 |          2 | 7th comment |
|          8 |       6 |          5 | 8th comment |
+------------+---------+------------+-------------+

After
+------------+---------+------------+-------------+
| comment_id | user_id | article_id | comment     |
+------------+---------+------------+-------------+
|          1 |       5 |          2 | 1st comment |
|          2 |       3 |          1 | 2nd comment |
|          3 |       5 |          2 | 3rd comment |
|          4 |       1 |          2 | 4th comment |
|          6 |       1 |         10 | 6th comment |
|          7 |       3 |          2 | 7th comment |
|          8 |       6 |          5 | 8th comment |
+------------+---------+------------+-------------+

*/


DELETE FROM Articles
WHERE article_id = 8;
/*
Before
+------------+---------+-------------+-------------+
| article_id | user_id | category_id | content     |
+------------+---------+-------------+-------------+
|          1 |       2 |           2 | 1st Article |
|          2 |       1 |           3 | Admin note  |
|          3 |       2 |           1 | 2nd article |
|          4 |       2 |           2 | 3rd article |
|          5 |       3 |           1 | 4th article |
|          6 |       5 |           2 | 5th article |
|          7 |       5 |           1 | 6th article |
|          8 |       3 |           4 | 7th article |
|          9 |       5 |           2 | 8th article |
|         10 |       3 |           4 | 9th article |
+------------+---------+-------------+-------------+

After
+------------+---------+-------------+-------------+
| article_id | user_id | category_id | content     |
+------------+---------+-------------+-------------+
|          1 |       2 |           2 | 1st Article |
|          2 |       1 |           3 | Admin note  |
|          3 |       2 |           1 | 2nd article |
|          4 |       2 |           2 | 3rd article |
|          5 |       3 |           1 | 4th article |
|          6 |       5 |           2 | 5th article |
|          7 |       5 |           1 | 6th article |
|          9 |       5 |           2 | 8th article |
|         10 |       3 |           4 | 9th article |
+------------+---------+-------------+-------------+
*/


--- Q2 ---
SELECT article_id, content
FROM Articles INNER JOIN Users
USING(user_id)
WHERE name = 'user3';
/*
+------------+-------------+
| article_id | content     |
+------------+-------------+
|          5 | 4th article |
|         10 | 9th article |
+------------+-------------+
*/

SET @name = 'user3';

SELECT article_id, content
FROM Articles INNER JOIN Users
USING(user_id)
WHERE name = @name;
/*
+------------+-------------+
| article_id | content     |
+------------+-------------+
|          5 | 4th article |
|         10 | 9th article |
+------------+-------------+
*/


-- Q3 --
SELECT article_id, content, comment_id, comment
FROM Articles INNER JOIN Users
USING(user_id)
INNER JOIN Comments
USING(article_id)
WHERE name = 'user3';
/*
+------------+-------------+------------+-------------+
| article_id | content     | comment_id | comment     |
+------------+-------------+------------+-------------+
|          5 | 4th article |          8 | 8th comment |
|         10 | 9th article |          6 | 6th comment |
+------------+-------------+------------+-------------+
*/

SELECT a.article_id AS article_id, a.content AS content,
       comment_id, comment
FROM Comments INNER JOIN (
  SELECT article_id, content
  FROM Articles INNER JOIN Users
  USING(user_id)
  WHERE name = 'user3'
) AS a
USING (article_id);
/*
+------------+-------------+------------+-------------+
| article_id | content     | comment_id | comment     |
+------------+-------------+------------+-------------+
|          5 | 4th article |          8 | 8th comment |
|         10 | 9th article |          6 | 6th comment |
+------------+-------------+------------+-------------+
*/

--- Q4 ---
SELECT article_id, content
FROM Articles AS a
WHERE NOT EXISTS (
  SELECT ''
  FROM Comments c 
  WHERE c.article_id = a.article_id
);
/*
+------------+-------------+
| article_id | content     |
+------------+-------------+
|          3 | 2nd article |
|          4 | 3rd article |
|          6 | 5th article |
|          7 | 6th article |
|          9 | 8th article |
+------------+-------------+
*/


--- Q5 ---
SELECT a.article_id AS article_id, a.content
FROM Articles AS a INNER JOIN (
  SELECT article_id, COUNT(*) AS c 
  FROM Comments 
  GROUP BY article_id
  ORDER BY c DESC
  LIMIT 1
) AS t
USING(article_id);
/*
+------------+------------+
| article_id | content    |
+------------+------------+
|          2 | Admin note |
+------------+------------+
*/


--- Q6 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by ) ---

SELECT a.article_id AS article_id, content
FROM Articles AS a LEFT OUTER JOIN (
  SELECT user_id, article_id, COUNT(*) c
  FROM Comments
  GROUP BY user_id, article_id
  HAVING c > 1
) AS t 
USING(article_id)
WHERE t.c IS NULL;
/*
+------------+-------------+
| article_id | content     |
+------------+-------------+
|          1 | 1st Article |
|          3 | 2nd article |
|          4 | 3rd article |
|          5 | 4th article |
|          6 | 5th article |
|          7 | 6th article |
|          9 | 8th article |
|         10 | 9th article |
+------------+-------------+
*/