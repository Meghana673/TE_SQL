use ORG;

create table Salesman(
Salesman_id INT NOT NULL PRIMARY KEY,
Name CHAR (30),
City CHAR (30),
Commission FLOAT (20)
);

INSERT INTO Salesman
(Salesman_id, Name, City, Commission) VALUES
	(5001, 'James Hoog', 'New York', 0.15),
	(5002, 'Nail Knite', 'Paris', 0.13),
	(5005, 'Pit Alex', 'London', 0.11),
	(5006, 'Mc Lyon', 'Paris', 0.14),
	(5007, 'Paul Adam', 'Rome', 0.13),
	(5003, 'Lauson Hen', 'San Jose', 0.12)

select * from Salesman

--1.	From the following table, create a view for those salespeople who belong to the city of New York. 

CREATE VIEW people_in_newyork
AS select * from Salesman
WHERE City = 'New York';

Select * from people_in_newyork


--2.	From the following table, create a view for all salespersons. Return salesperson ID, name, and city.  
CREATE VIEW all_salesperson
AS SELECT Salesman_id, Name, City FROM Salesman;

Select * from all_salesperson


--3.	From the following table, create a view to count the number of salespeople in each city. Return city, number of salespersons.
CREATE VIEW all_city_count
AS SELECT City, COUNT (DISTINCT Salesman_id) as S_count
FROM Salesman GROUP BY City;


Select * from all_city_count


create table customer(
Customer_id INT NOT NULL PRIMARY KEY,
cust_name varchar(50),
city varchar(30),
grade int,
salesman_id int
);

insert into customer
(Customer_id, cust_name, city, grade, salesman_id) values
(3002, 'Nick Rimando', ' New York', 100, 5001),
(3007, 'Brad Davis' ,'New York',200,5001),
(3005,'Graham Zusi','California',200,5002),
(3008,'Julian Green','London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),
(3009,'Geoff Cameron','Berlin',100,5003),
(3003,'Jozy Altidor','Moscow',200,5007)

Select * from customer;

--4.	From the following table, create a view that counts the number of customers in each grade. 
create view gradecount 
as select grade, count(*) as c_count
from customer group by grade;

Select * from gradecount


create table orders(
order_no int,
purch_amt float(50),
ord_date Date,
customer_id int,
salesman_id int
);


insert into orders
(order_no, purch_amt, ord_date,customer_id,salesman_id) values
(70001,150.5,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001)

Select * from orders

--5.	From the following tables, create a view to get the salesperson and customer by name. 
---Return order name, purchase amount, salesperson ID, name, customer name.

CREATE VIEW name_orders
AS SELECT order_no, purch_amt, o.salesman_id, name, cust_name
FROM orders o, customer c, salesman s
WHERE o.Customer_id = c.Customer_id
AND o.salesman_id = s.salesman_id;

Select * from name_orders