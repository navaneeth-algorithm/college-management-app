--create Database college Management
CREATE DATABASE CollegeManagement;

--drop Database collegeManagement
/*
DROP DATABASE CollegeManagement;

*/
--BACKUP DATABASE with file path in command prompt
/*
For More:
https://www.linode.com/docs/databases/mysql/use-mysqldump-to-back-up-mysql-or-mariadb/
*/
--mysqldump -u root -p  CollegeManagement > CollegeManagement-$(date +%F).sql


/*

INDEPENDENT TABLES

*/
--create Table Country
CREATE TABLE COUNTRY (
    Id INT PRIMARY KEY,
    Name VARCHAR(255)
    );

/*
create table using other TABLE

CREATE TABLE new_table_name AS
    SELECT Column1,Column2...
    FROM existing_table_name
    WHERE .....;

*/

--drop Table Country
/*
Drop Entire Table

DROP TABLE Country;

*/

--Truncate Table Country
/*
Truncate use to delete Data inside table

TRUNCATE TABLE Country;
*/

--Table State
CREATE TABLE State(
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
);

--Table User Type
CREATE TABLE UserType(
Id INT PRIMARY KEY,
Type VARCHAR(255),
ActiveStatus INT,
);

--Table Sem
CREATE TABLE Sem(
Id INT PRIMARY KEY,
Name VARCHAR(255),
ActiveStatus INT
);

--Table Days
CREATE TABLE Day(
Id INT PRIMARY KEY,
Name VARCHAR(255),
ActiveStatus INT
);

--Table Marks
CREATE TABLE Marks(
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    AllocatedMarks INT
);

