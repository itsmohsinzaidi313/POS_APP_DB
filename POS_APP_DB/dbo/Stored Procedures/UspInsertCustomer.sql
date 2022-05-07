create proc [dbo].[UspInsertCustomer]

@COId as int ,
@Vendor as nvarchar(50),
@Address as nvarchar(50),
@CellNo as nvarchar(50),
@CAId as int

as


insert into Customer
(
CAId,
COId,
Customer ,
Address ,
CellNo 
)
Values
(
@CAId,
@COId,
@Vendor ,
@Address ,
@CellNo 
)





