use ORG;

create table Student
(
   SID int,
   SName varchar(20),
   DEPARTMENT varchar(20)
)
--1. Synonyms

create synonym work for Worker;

create synonym cb for Bonus;

select * from  Bonus; 

select * from cb;


--synonyms - where they get stored in SQL Server
Select * from sys.synonyms 

--2. Index

--clustered index 
--PRIMARY KEY -> AUTOMATICALLY CLUSTERED INDEX IS CREATED

create clustered index ind_SID on Student(SID)



--NON-CLUSTERED
--UNIQUE KEY -> AUTOMATICALLY UNIQUE NON-CLUSTERED INDEX IS CREATED 

create index ind_SName on Student(SName)



--Filtered index
create index ind_SDep on Student(DEPARTMENT) where DEPARTMENT='CSE'

Select * from Student;


--3. Simple and Complex Views

select * from Worker;

--simple view
Create view work_View
as
select * from Worker where DEPARTMENT='Admin'

--Retrieve the view
select * from work_View


--2. Complex View
Select * from Student;

create table Student_Dept
(
DID int Primary Key,
DName varchar(20),
DHead varchar(20)
)

alter table Student add SDept Int

insert into Student_Dept values(1,'CSE','Ana'),(2,'ECE','Peter'),(3,'ISE','Ross'),(4,'MECH','Eva'),(5,'CSE','Matty')

update Student set DEPARTMENT=8 where SID=102;

select SID,SName,DID,DName,DHead from Student inner join Student_Dept on DEPARTMENT=DID;



create view Student_Dep
as
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Student as s inner join Student_Dept as sd on s.DEPARTMENT=sd.DID;

select * from Student_Dep;
--4. Sequence

--CREATE 



create sequence StudentID as int start with 100 increment by 1;

insert into Student values(NEXT VALUE FOR StudentID,'Alice','CSE')
insert into Student values(NEXT VALUE FOR StudentID,'Nancy','ECE')
insert into Student values(NEXT VALUE FOR StudentID,'Kat','ISE')
insert into Student values(NEXT VALUE FOR StudentID,'Richard','CSE')

Select * from Student;




