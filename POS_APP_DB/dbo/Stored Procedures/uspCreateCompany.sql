CREATE proc [dbo].[uspCreateCompany]
@Company as nvarchar(50),
@Address as nvarchar(50),
@ContactNo as nvarchar(50),
@Fax as nvarchar(50),
@Email as nvarchar(50),
@LogoName as nvarchar(50)
as

declare @COId int;
set @COId = 0;
IF EXISTS (select COId from Company where Company = @Company) 
Begin
set @COId = 0;
End
else
Begin
insert into Company
(
Company,
Address,
ContactNo,
Fax,
Email,
LogoName
)
values 
(
@Company,
@Address,
@ContactNo,
@Fax,
@Email,
@LogoName

)
set @COId = scope_identity();
End

Select @COId;



