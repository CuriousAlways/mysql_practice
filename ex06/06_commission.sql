--- CREATE TABLE ---
CREATE TABLE Departments(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(20) NOT NULL
);

CREATE TABLE Employees(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(30) NOT NULL,
  SALARY INT NOT NULL,
  DEPARTMENT_ID INT NOT NULL,
  CONSTRAINT fk_department FOREIGN KEY (DEPARTMENT_ID) REFERENCES Departments(ID)
);

CREATE TABLE Commissions(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  EMPLOYEE_ID INT NOT NULL,
  COMMISSION_AMOUNT INT NOT NULL,
  CONSTRAINT fk_employee FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees(ID)
);


--- INSERT VALUES
INSERT INTO Departments (NAME)
VALUES ('Banking'),
('Insurance'),
('Services');


INSERT INTO Employees (NAME, SALARY, DEPARTMENT_ID)
VALUES ('Chris Gayle', 1000000, 1),
('Michael Clarke', 800000, 2),
('Rahul Dravid', 700000, 1),
('Ricky Pointing', 600000, 2),
('Albie Morkel', 650000, 2),
('Wasim Akram', 750000, 3);

INSERT INTO Commissions (EMPLOYEE_ID, COMMISSION_AMOUNT)
VALUES (1, 5000),
(2, 3000),
(3, 4000),
(1, 4000),
(2, 3000),
(4, 2000),
(5, 1000),
(6, 5000);


--- Q1
SELECT NAME 
FROM Employees AS e INNER JOIN (
  SELECT EMPLOYEE_ID, SUM(COMMISSION_AMOUNT) AS TOTAL
  FROM Commissions
  GROUP BY EMPLOYEE_ID
  ORDER BY TOTAL DESC
  LIMIT 1
) AS c
ON c.EMPLOYEE_ID = e.ID;
/*
+-------------+
| NAME        |
+-------------+
| Chris Gayle |
+-------------+
*/

--- Q2
SELECT NAME 
FROM Employees AS e INNER JOIN (
  SELECT EMPLOYEE_ID, SUM(COMMISSION_AMOUNT) AS TOTAL
  FROM Commissions
  GROUP BY EMPLOYEE_ID
  ORDER BY TOTAL DESC
  LIMIT 3,1
) AS c
ON c.EMPLOYEE_ID = e.ID;
/*
+--------------+
| NAME         |
+--------------+
| Rahul Dravid |
+--------------+
*/


--- Q3
SELECT d.NAME AS NAME, t.TOTAL 
FROM Departments AS d INNER JOIN (
  SELECT DEPARTMENT_ID, SUM(COMMISSION_AMOUNT) AS TOTAL
  FROM Commissions AS c INNER JOIN Employees e 
  ON e.ID = c.EMPLOYEE_ID
  GROUP BY DEPARTMENT_ID
  ORDER BY TOTAL DESC
  LIMIT 1
) AS t 
ON d.ID = t.DEPARTMENT_ID;
/*
+---------+-------+
| NAME    | TOTAL |
+---------+-------+
| Banking | 13000 |
+---------+-------+
*/

--- Q4
SELECT GROUP_CONCAT(NAME separator ', ') AS EMPLOYEES, c.COMMISSION_AMOUNT AS COMMISSION 
FROM Employees AS e INNER JOIN Commissions AS c
ON e.ID = c.EMPLOYEE_ID
WHERE c.COMMISSION_AMOUNT > 3000
GROUP BY COMMISSION;
/*
+---------------------------+------------+
| EMPLOYEES                 | COMMISSION |
+---------------------------+------------+
| Rahul Dravid, Chris Gayle |       4000 |
| Chris Gayle, Wasim Akram  |       5000 |
+---------------------------+------------+

*/