CREATE DATABASE Bank;


CREATE TABLE IF NOT EXISTS accounts(
  account_no INT PRIMARY KEY,
  id INT NOT NULL,
  balance INT NOT NULL 
);

CREATE TABLE IF NOT EXISTS users(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  email VARCHAR(30) NOT NULL,
  account_no INT UNIQUE NOT NULL,
  CONSTRAINT fk_account FOREIGN KEY(account_no) REFERENCES accounts(account_no)
);

---- INSERT VALUES
INSERT INTO accounts 
VALUES (9900, 1, 100),
(9911, 2, 0),
(9922, 3, 600);

INSERT INTO users (name, email, account_no)
VALUES ('userA', 'userA@email.com', 9900),
('userB', 'userB@email.com', 9911),
('userC', 'userC@email.com', 9922);

--- Before Transaction
SELECT * FROM accounts;
/*
+------------+----+---------+
| account_no | id | balance |
+------------+----+---------+
|       9900 |  1 |     100 |
|       9911 |  2 |       0 |
|       9922 |  3 |     600 |
+------------+----+---------+
*/

SELECT * FROM users;
/*
+----+-------+-----------------+------------+
| id | name  | email           | account_no |
+----+-------+-----------------+------------+
|  1 | userA | userA@email.com |       9900 |
|  2 | userB | userB@email.com |       9911 |
|  3 | userC | userC@email.com |       9922 |
+----+-------+-----------------+------------+
*/


--- Transaction 
START TRANSACTION;

UPDATE accounts AS a INNER JOIN users AS u 
USING(account_no)
SET a.balance = a.balance + 1000
WHERE u.name = 'userA';

COMMIT;



START TRANSACTION;

UPDATE accounts AS a INNER JOIN users AS u 
USING(account_no)
SET a.balance = a.balance - 500
WHERE u.name = 'userA';

COMMIT;



START TRANSACTION;

UPDATE accounts AS a INNER JOIN users AS u 
USING(account_no)
SET a.balance = a.balance - 200
WHERE u.name = 'userA';

UPDATE accounts AS a INNER JOIN users AS u 
USING(account_no)
SET a.balance = a.balance + 200
WHERE u.name = 'userB';

-- execute rollback if any of the above two UPDATE throws error
ROLLBACK;

COMMIT;

--- After successfull trasaction
SELECT * FROM accounts;
/*
+------------+----+---------+
| account_no | id | balance |
+------------+----+---------+
|       9900 |  1 |     400 |
|       9911 |  2 |     200 |
|       9922 |  3 |     600 |
+------------+----+---------+
*/

SELECT * FROM users;
/*
+----+-------+-----------------+------------+
| id | name  | email           | account_no |
+----+-------+-----------------+------------+
|  1 | userA | userA@email.com |       9900 |
|  2 | userB | userB@email.com |       9911 |
|  3 | userC | userC@email.com |       9922 |
+----+-------+-----------------+------------+
*/