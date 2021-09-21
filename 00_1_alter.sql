CREATE TABLE testing_table (
  name VARCHAR(20),
  contact_name VARCHAR(20),
  roll_no VARCHAR(20)
);

/*
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| name         | varchar(20) | YES  |     | NULL    |       |
| contact_name | varchar(20) | YES  |     | NULL    |       |
| roll_no      | varchar(20) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
*/

-- version 8.0
ALTER TABLE testing_table
DROP COLUMN name,
RENAME COLUMN contact_name TO username,
ADD COLUMN first_name VARCHAR(20),
ADD COLUMN last_name VARCHAR(20),
MODIFY COLUMN roll_no INT;

/*
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| username   | varchar(20) | YES  |     | NULL    |       |
| roll_no    | int         | YES  |     | NULL    |       |
| first_name | varchar(20) | YES  |     | NULL    |       |
| last_name  | varchar(20) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
*/

-- version 5.7
ALTER TABLE testing_table
DROP COLUMN name,
CHANGE COLUMN contact_name username VARCHAR(20),
ADD COLUMN first_name VARCHAR(20),
ADD COLUMN last_name VARCHAR(20),
MODIFY COLUMN roll_no INT;