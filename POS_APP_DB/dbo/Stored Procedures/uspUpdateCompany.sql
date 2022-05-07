

CREATE proc [dbo].[uspUpdateCompany]
@COId as int,
@Company as nvarchar(50),
@Address as nvarchar(50),
@ContactNo as nvarchar(50),
@Fax as nvarchar(50),
@Email as nvarchar(50),
@LogoName as nvarchar(50)
--@Logo image

as
Update Company set 
Company = @Company ,
Address=@Address,
ContactNo=@ContactNo,
Fax =@Fax ,
Email=@Email,
LogoName=@LogoName
--Logo=@Logo
where COId = @COId