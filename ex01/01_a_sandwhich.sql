--- create tables ---
CREATE TABLE IF NOT EXISTS TASTES(
  Name VARCHAR(15),
  Filling VARCHAR(15),
  PRIMARY KEY(Name, Filling)
);

CREATE TABLE IF NOT EXISTS LOCATIONS(
  LName VARCHAR(20),
  Phone INT NOT NULL,
  Address VARCHAR(40) NOT NULL,
  PRIMARY KEY(LName)
);

CREATE TABLE IF NOT EXISTS SANDWICHES(
  Location VARCHAR(20),
  Bread ENUM('Rye', 'White', 'Whole'),
  Filling VARCHAR(15),
  Price DECIMAL(4,2)  NOT NULL,
  PRIMARY KEY(Location, Bread, Filling),
  CONSTRAINT fk_location FOREIGN KEY(Location) REFERENCES LOCATIONS(LName)
);

--- SCHEMA --- 

DESC  TASTES;
/*
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| Name    | varchar(15) | NO   | PRI | NULL    |       |
| Filling | varchar(15) | NO   | PRI | NULL    |       |
+---------+-------------+------+-----+---------+-------+
*/

DESC LOCATIONS;
/*
+----------+-----------------------------+------+-----+---------+-------+
| Field    | Type                        | Null | Key | Default | Extra |
+----------+-----------------------------+------+-----+---------+-------+
| Location | varchar(20)                 | NO   | PRI | NULL    |       |
| Bread    | enum('Rye','White','Whole') | NO   | PRI | NULL    |       |
| Filling  | varchar(15)                 | NO   | PRI | NULL    |       |
| Price    | decimal(4,2)                | NO   |     | NULL    |       |
+----------+-----------------------------+------+-----+---------+-------+
*/

DESC SANDWICHES;
/*
+----------+-----------------------------+------+-----+---------+-------+
| Field    | Type                        | Null | Key | Default | Extra |
+----------+-----------------------------+------+-----+---------+-------+
| Location | varchar(20)                 | NO   | PRI | NULL    |       |
| Bread    | enum('Rye','White','Whole') | NO   | PRI | NULL    |       |
| Filling  | varchar(15)                 | NO   | PRI | NULL    |       |
| Price    | decimal(2,2)                | NO   |     | NULL    |       |
+----------+-----------------------------+------+-----+---------+-------+
*/


--- INSERT VALUES ---
INSERT INTO TASTES 
VALUES ('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

INSERT INTO LOCATIONS
VALUES ('Lincoln', 6834523, 'Lincoln Place'),
("O'Neill's", 6742134, 'Pearse St'),
("old Nag", 7678132, 'Dame St'),
('Buttery', 7023421, 'College St');

INSERT INTO SANDWICHES
VALUES ('Lincoln', 'Rye', 'Ham', 1.25),
("O'Neill's", 'White', 'Cheese', 1.20),
("O'Neill's", 'Whole', 'Ham', 1.25),
('old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
("O'Neill's", "White", 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.30),
('old Nag', 'Rye', 'Ham', 1.40);


--- QUERIES --- 

-- Q1 --
SELECT LName, Phone, Address
FROM LOCATIONS
WHERE LName IN (
  SELECT Location 
  FROM SANDWICHES AS s
  WHERE EXISTS (
    SELECT ''
    FROM TASTES AS t
    WHERE Name = 'Jones' AND s.Filling = t.Filling
  )
);
/*
+-----------+---------+------------+
| LName     | Phone   | Address    |
+-----------+---------+------------+
| Buttery   | 7023421 | College St |
| O'Neill's | 6742134 | Pearse St  |
+-----------+---------+------------+
*/

-- Q2 --
SELECT DISTINCT LName, Phone, Address
FROM LOCATIONS AS l INNER JOIN SANDWICHES AS s
ON l.LName = s.Location
NATURAL JOIN TASTES
WHERE Name = 'Jones';
/*
+-----------+---------+------------+
| LName     | Phone   | Address    |
+-----------+---------+------------+
| Buttery   | 7023421 | College St |
| O'Neill's | 6742134 | Pearse St  |
+-----------+---------+------------+
*/

-- Q3 --
SELECT s.Location AS Location, COUNT(*) 
FROM TASTES NATURAL JOIN (
  SELECT DISTINCT Location, Filling
  FROM SANDWICHES
) s
GROUP BY s.Location;
/*
+-----------+----------+
| Location  | COUNT(*) |
+-----------+----------+
| Lincoln   |        3 |
| old Nag   |        3 |
| Buttery   |        3 |
| O'Neill's |        5 |
+-----------+----------+
*/