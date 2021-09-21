-- create database
CREATE DATABASE vtapp;

-- create user
CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'vtApp123!';

-- grant permission
GRANT ALL PRIVILEGES ON vtapp . * TO 'vtapp_user'@'localhost';

-- reloading privileges
FLUSH PRIVILEGES;


-- viewing users
SELECT db, host, user FROM mysql.db;
/*
+--------------------+-----------+---------------+
| db                 | host      | user          |
+--------------------+-----------+---------------+
| ap                 | localhost | ap_tester     |
| ex                 | localhost | ap_tester     |
| my_guitar_shop     | localhost | mgs_user      |
| performance_schema | localhost | mysql.session |
| sys                | localhost | mysql.sys     |
| vtapp              | localhost | vtapp_user    |
+--------------------+-----------+---------------+
*/