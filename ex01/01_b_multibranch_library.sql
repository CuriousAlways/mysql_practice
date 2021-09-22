--- CREATE TABLE ---
CREATE TABLE Branches(
  BCode VARCHAR(2) PRIMARY KEY,
  Librarian VARCHAR(15),
  Address VARCHAR(30)
);

CREATE TABLE Titles(
  Title VARCHAR(30) PRIMARY KEY,
  Author VARCHAR(15) NOT NULL,
  Publisher VARCHAR(20) NOT NULL
);

CREATE TABLE Holdings(
  Branch VARCHAR(2),
  Title VARCHAR(30),
  `#copies` int,
  PRIMARY KEY(Branch, Title),
  CONSTRAINT fk_branch FOREIGN KEY(Branch) REFERENCES Branches (BCode),
  CONSTRAINT fk_title FOREIGN KEY(Title) REFERENCES Titles (Title)
);


--- SCHEMA ---
DESC Branches;
/*
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| BCode     | varchar(2)  | NO   | PRI | NULL    |       |
| Librarian | varchar(15) | YES  |     | NULL    |       |
| Address   | varchar(30) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
*/

DESC Titles;
/*
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| Title     | varchar(30) | NO   | PRI | NULL    |       |
| Author    | varchar(15) | NO   |     | NULL    |       |
| Publisher | varchar(20) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
*/

DESC Holdings;
/*
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| Branch  | varchar(2)  | NO   | PRI | NULL    |       |
| Title   | varchar(30) | NO   | PRI | NULL    |       |
| #copies | int         | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
*/


--- INSERT VALUES ---
INSERT INTO Branches
VALUES ('B1', 'John Smith', '2 Anglesea Rd'),
('B2', 'Mary Jones', '34 Pearse St'),
('B3', 'Francis Owens', 'Grange X');


INSERT INTO Titles
VALUES ('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

INSERT INTO Holdings
VALUES ('B1', 'Susannah', 3),
('B1', 'How to Fish', 2),
('B1', 'A History of Dublin', 1),
('B2', 'How to Fish', 4),
('B2', 'Computers', 2),
('B2', 'The Wife', 3),
('B3', 'A History of Dublin', 1),
('B3', 'Computers', 4),
('B3', 'Susannah', 3),
('B3', 'The Wife', 1);


--- QUERIES --- 

-- Q1 --
SELECT DISTINCT h.Title AS Title
FROM Holdings h INNER JOIN Titles AS t
USING(Title)
WHERE t.Publisher = 'Macmillan';
/*
+----------+
| Title    |
+----------+
| Susannah |
| The Wife |
+----------+
*/

-- Q2 --
SELECT DISTINCT Branch
FROM Holdings h 
WHERE Title IN (
  SELECT Title
  FROM Titles
  WHERE Author = 'Ann Brown'
);
/*
+--------+
| Branch |
+--------+
| B1     |
| B3     |
| B2     |
+--------+
*/

-- Q3 --
SELECT DISTINCT Branch
FROM Holdings h INNER JOIN Titles
USING(Title)
WHERE Author = 'Ann Brown'; 
/*
+--------+
| Branch |
+--------+
| B1     |
| B3     |
| B2     |
+--------+
*/


-- Q4 --
SELECT Branch, SUM(`#copies`) AS 'Total no of Books'
FROM Holdings
GROUP BY Branch;
/*
+--------+-------------------+
| Branch | Total no of Books |
+--------+-------------------+
| B1     |                 6 |
| B2     |                 9 |
| B3     |                 9 |
+--------+-------------------+
*/