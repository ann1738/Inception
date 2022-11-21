--RUN THROUGH "mysql -uroot -ppassword < init.sql"

--Declaring Variables
--DECLARE @SuperUser VARCHAR(20)='superPowerRanger';
--DECLARE @NormalUser AS VARCHAR(100)='anasr';

--Creating the Database
CREATE DATABASE IF NOT EXISTS duck_database;

--Creating the super user
CREATE USER IF NOT EXISTS 'superPowerRanger'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'superPowerRanger';

--Creating the normal user
CREATE USER IF NOT EXISTS 'anasr'@'%' IDENTIFIED BY 'password';

--Update privileges
FLUSH PRIVILEGES;