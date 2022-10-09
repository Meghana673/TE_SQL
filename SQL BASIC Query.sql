CREATE DATABASE ORG;

USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);



INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '2022-09-20 10:00:00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '2022-06-11 08:40:00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '2022-02-20 09:00:00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '2022-02-20 11:40:00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '2022-06-11 04:35:00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '2022-06-11 12:10:07', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '2022-01-20 07:20:00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '2022-04-16 02:15:00', 'Admin');


CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);


INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '2022-02-20'),
		(002, 3000, '2022-06-11'),
		(003, 4000, '2022-02-20'),
		(001, 4500, '2022-02-20'),
		(002, 3500, '2022-06-11');


CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);



INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2022-02-20 10:30:00'),
 (002, 'Executive', '2022-06-11 08:00:00'),
 (008, 'Executive', '2022-06-11 04:20:00'),
 (005, 'Manager', '2022-06-11 08:10:00'),
 (004, 'Asst. Manager', '2022-06-11 09:50:00'),
 (007, 'Executive', '2022-06-11 11:00:00'),
 (006, 'Lead', '2022-06-11 12:00:00'),
 (003, 'Lead', '2022-06-11 2:00:00');

 create synonym works for Worker;

  select * from works; 
  
 select * from Worker; 
 select * from Bonus; 
 select * from Title; 

 --Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.

select FIRST_NAME AS WORKER_NAME FROM Worker;

--Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(FIRST_NAME) FROM Worker;


--Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT  DISTINCT DEPARTMENT FROM Worker;


---Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTRING(FIRST_NAME,1,3) FROM Worker;

--Q-5. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

SELECT  DISTINCT DEPARTMENT,LEN(DEPARTMENT) AS COUNT FROM Worker;

--Q-6. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

SELECT CONCAT(FIRST_NAME,'',LAST_NAME) AS COMPLETE_NAME  FROM Worker;

--Q-7. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM Worker WHERE FIRST_NAME='Vipul' OR FIRST_NAME='Satish';

--Q-8. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
SELECT * FROM Worker WHERE DEPARTMENT='ADMIN';


--Q-9. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a';

--Q-10. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a%';
