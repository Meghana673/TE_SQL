use ORG;

--1. Scalar Function with 2 parameters - any concept
create function Fn_Subtract(@a int, @b int)
returns int
as
begin
	return @a - @b
end

--call the function
select dbo.Fn_Subtract(4,2) as Result



--2. Procedure with OUTPUT parameter

create procedure sp_TotalStudent(@totalstu int OUTPUT)
as
Begin
	Select @totalstu=count(SID) from Student
End

--execute the procedure with ouput parameter
--execute the below three lines at once
Declare @Result int
exec sp_TotalStudent @Result OUTPUT --OUPUT is mandatory
Print @Result


--3. Trigger to restrict DML access between 6:00PM to 10.00AM

select * from Bonus

create trigger trg_bonus_dml --trigger name
on Bonus -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	if ((DATEPART(HH,GETDATE())>17) and (DATEPART(HH,GETDATE())<10))
	BEGIN
		print 'You cannot insert into the demo table after 6:00PM'
		Rollback transaction 
	END
end

--Restricting the access for DML operations on demo table after 13:00PM
update Bonus set BONUS_AMOUNT=6000 where WORKER_REF_ID=3
INSERT INTO Bonus VALUES (007, 5000, '2022-02-20 19:10:00')
delete from Bonus where WORKER_REF_ID=7

--4. Server-scope trigger to restrict DDL access
create table demo
(
id int,
name varchar(20)
)

select * from demo;

create trigger trg_DDL_AllDB
on ALL Server
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on any Database'
	Rollback Transaction
End
create table demo1
(
id int,
name varchar(20)
)

use TE_Core_MVC

create table demo1
(
id int,
name varchar(20)
)

--disable trigger
Disable trigger trg_DDL_AllDB on ALL SERVER

--5. Working of explicit transaction with Save transaction
BEGIN TRANSACTION
	insert into demo values(4,'Matty');
	--SAVEPOINT
	SAVE TRANSACTION insert_stmt
	delete from demo where id=3;
	ROLLBACK TRANSACTION insert_stmt
COMMIT TRANSACTION


--6. Difference between throw and Raiserror in exception handling

create procedure sp_DivideByZero
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	IF(@num2=0)
	BEGIN
		RAISERROR('Cannot Divide By Zero',16,127)
	END
	ELSE
	BEGIN
		SET @Result=@num1/@num2
		PRINT 'Value is:' + CAST(@Result as varchar)
	END
END

--execute a procedure
EXEC sp_DivideByZero 10,0

--RAISERROR -> 3 PARAMETERS
--1. MESSAGE - ''
--2. SEVERITY - 0 TO 24
--	0-9 ->  Not severe -> error status information
--	11-16 -> Runtime errors - error messages are created by the user
--	17-19 -> errors that cannot be rectified by the developer and redirected to the system administrator
--	20-24 -> Fatal errors - Most severe 
--3. STATE - 0-127

-- TRY/CATCH WITH RAISERROR

create procedure sp_DivideByZeroTryCatch
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	BEGIN TRY
		BEGIN
			IF(@num2=0)
			--RAISERROR('Cannot Divide By Zero',16,127) -- We can either use ERROR_NUMBER() or ERROR_MESSAGE()
			THROW 50001,'Cannot Divide By Zero',1 -- ERROR_NUMBER() & ERROR_MESSAGE() & ERROR_STATE() & ERROR_SEVERITY() is 16 by default
			SET @Result=@num1/@num2
			PRINT 'Value is:' + CAST(@Result as varchar)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()		
	END CATCH
END



execute sp_DivideByZeroTryCatch 10,0