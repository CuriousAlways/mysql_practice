--- CREATE TABLES ---
CREATE TABLE users(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  type ENUM('admin', 'normal') DEFAULT 'normal' NOT NULL
);


CREATE TABLE categories(
  id INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(30) NOT NULL
);

CREATE TABLE articles(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  content TEXT NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
  CONSTRAINT fk_category FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE comments(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  article_id INT NOT NULL,
  comment TEXT NOT NULL,
  CONSTRAINT fk2_user FOREIGN KEY(user_id) REFERENCES users(id),
  CONSTRAINT fk_article FOREIGN KEY(article_id) REFERENCES articles(id)
);

--- SCHEMA ---
DESC users;
/*
+-------+------------------------+------+-----+---------+----------------+
| Field | Type                   | Null | Key | Default | Extra          |
+-------+------------------------+------+-----+---------+----------------+
| id    | int                    | NO   | PRI | NULL    | auto_increment |
| name  | varchar(20)            | NO   |     | NULL    |                |
| type  | enum('admin','normal') | NO   |     | normal  |                |
+-------+------------------------+------+-----+---------+----------------+
*/

DESC uategories;
/*
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int         | NO   | PRI | NULL    | auto_increment |
| type  | varchar(30) | NO   |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
*/

DESC articles;
/*
+-------------+------+------+-----+---------+----------------+
| Field       | Type | Null | Key | Default | Extra          |
+-------------+------+------+-----+---------+----------------+
| id          | int  | NO   | PRI | NULL    | auto_increment |
| user_id     | int  | NO   | MUL | NULL    |                |
| category_id | int  | NO   | MUL | NULL    |                |
| content     | text | NO   |     | NULL    |                |
+-------------+------+------+-----+---------+----------------+
*/

DESC comments;
/*
+------------+------+------+-----+---------+----------------+
| Field      | Type | Null | Key | Default | Extra          |
+------------+------+------+-----+---------+----------------+
| id         | int  | NO   | PRI | NULL    | auto_increment |
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
UPDATE users
SET type = 'admin'
WHERE id = 6;
/*
 before 
+----+-------+--------+
| id | name  | type   |
+----+-------+--------+
|  1 | user1 | admin  |
|  2 | user2 | normal |
|  3 | user3 | normal |
|  4 | user4 | normal |
|  5 | user5 | normal |
|  6 | user6 | normal |
+----+-------+--------+

after
+----+-------+--------+
| id | name  | type   |
+----+-------+--------+
|  1 | user1 | admin  |
|  2 | user2 | normal |
|  3 | user3 | normal |
|  4 | user4 | normal |
|  5 | user5 | normal |
|  6 | user6 | admin  |
+----+-------+--------+
*/

UPDATE categories
SET type = 'Guidelines'
WHERE id = 3;
/*
 before 
+----+-------------+
| id | type        |
+----+-------------+
|  1 | Programming |
|  2 | databases   |
|  3 | General     |
|  4 | random      |
+----+-------------+

after
+----+-------------+
| id | type        |
+----+-------------+
|  1 | Programming |
|  2 | databases   |
|  3 | Guidelines  |
|  4 | random      |
+----+-------------+
*/

--- DELETE ---
DELETE FROM comments 
WHERE id = 5;
/*
Before
+----+---------+------------+-------------+
| id | user_id | article_id | comment     |
+----+---------+------------+-------------+
|  1 |       5 |          2 | 1st comment |
|  2 |       3 |          1 | 2nd comment |
|  3 |       5 |          2 | 3rd comment |
|  4 |       1 |          2 | 4th comment |
|  5 |       3 |          2 | 5th comment |
|  6 |       1 |         10 | 6th comment |
|  7 |       3 |          2 | 7th comment |
|  8 |       6 |          5 | 8th comment |
+----+---------+------------+-------------+

After
+----+---------+------------+-------------+
| id | user_id | article_id | comment     |
+----+---------+------------+-------------+
|  1 |       5 |          2 | 1st comment |
|  2 |       3 |          1 | 2nd comment |
|  3 |       5 |          2 | 3rd comment |
|  4 |       1 |          2 | 4th comment |
|  6 |       1 |         10 | 6th comment |
|  7 |       3 |          2 | 7th comment |
|  8 |       6 |          5 | 8th comment |
+----+---------+------------+-------------+

*/


DELETE FROM articles
WHERE id = 8;
/*
Before
+----+---------+-------------+-------------+
| id | user_id | category_id | content     |
+----+---------+-------------+-------------+
|  1 |       2 |           2 | 1st Article |
|  2 |       1 |           3 | Admin note  |
|  3 |       2 |           1 | 2nd article |
|  4 |       2 |           2 | 3rd article |
|  5 |       3 |           1 | 4th article |
|  6 |       5 |           2 | 5th article |
|  7 |       5 |           1 | 6th article |
|  8 |       3 |           4 | 7th article |
|  9 |       5 |           2 | 8th article |
| 10 |       3 |           4 | 9th article |
+----+---------+-------------+-------------+

After
+----+---------+-------------+-------------+
| id | user_id | category_id | content     |
+----+---------+-------------+-------------+
|  1 |       2 |           2 | 1st Article |
|  2 |       1 |           3 | Admin note  |
|  3 |       2 |           1 | 2nd article |
|  4 |       2 |           2 | 3rd article |
|  5 |       3 |           1 | 4th article |
|  6 |       5 |           2 | 5th article |
|  7 |       5 |           1 | 6th article |
|  9 |       5 |           2 | 8th article |
| 10 |       3 |           4 | 9th article |
+----+---------+-------------+-------------+
*/


--- Q2 ---
SELECT articles.id AS article_id, content
FROM articles INNER JOIN users
ON articles.user_id = users.id
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

SELECT articles.id AS article_id, content
FROM articles INNER JOIN users
ON articles.user_id = users.id
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
SELECT a.id AS article_id, content, c.id AS comment_id, comment
FROM articles AS a INNER JOIN users AS u
ON a.user_id = u.id
INNER JOIN comments AS c
ON a.id = c.article_id
WHERE name = 'user3';
/*
+------------+-------------+------------+-------------+
| article_id | content     | comment_id | comment     |
+------------+-------------+------------+-------------+
|          5 | 4th article |          8 | 8th comment |
|         10 | 9th article |          6 | 6th comment |
+------------+-------------+------------+-------------+
*/

SELECT s.article_id AS article_id, s.content AS content,
       c.id AS comment_id, comment
FROM comments AS c INNER JOIN (
  SELECT a.id AS article_id, content
  FROM articles AS a INNER JOIN users AS u
  ON a.user_id = u.id
  WHERE name = 'user3'
) AS s
ON s.article_id = c.article_id;
/*
+------------+-------------+------------+-------------+
| article_id | content     | comment_id | comment     |
+------------+-------------+------------+-------------+
|          5 | 4th article |          8 | 8th comment |
|         10 | 9th article |          6 | 6th comment |
+------------+-------------+------------+-------------+
*/

--- Q4 ---
SELECT id AS article_id, content
FROM articles AS a
WHERE NOT EXISTS (
  SELECT ''
  FROM comments c 
  WHERE c.article_id = a.id
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


SELECT a.id AS article_id, content 
FROM articles AS a LEFT OUTER JOIN comments AS c 
ON a.id = c.article_id
WHERE c.id IS NULL;

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
SELECT a.id AS article_id, content, COUNT(a.id) AS no_of_comments
FROM articles AS a INNER JOIN comments AS c 
ON a.id = c.article_id
GROUP BY a.id
ORDER BY no_of_comments DESC
LIMIT 1; 
/*
+------------+------------+----------------+
| article_id | content    | no_of_comments |
+------------+------------+----------------+
|          2 | Admin note |              4 |
+------------+------------+----------------+
*/


--- Q6 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by ) ---

SELECT a.id AS article_id, content, COUNT(c.id) AS no_of_comments
FROM articles AS a LEFT OUTER JOIN comments AS c
ON a.id = c.article_id
GROUP BY a.id
HAVING COUNT(DISTINCT a.id, c.id) <= 1; 
/*
+------------+-------------+----------------+
| article_id | content     | no_of_comments |
+------------+-------------+----------------+
|          1 | 1st Article |              1 |
|          3 | 2nd article |              0 |
|          4 | 3rd article |              0 |
|          5 | 4th article |              1 |
|          6 | 5th article |              0 |
|          7 | 6th article |              0 |
|          9 | 8th article |              0 |
|         10 | 9th article |              1 |
+------------+-------------+----------------+
*/