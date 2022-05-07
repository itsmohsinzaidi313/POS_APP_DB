


CREATE proc [dbo].[UspUpdateVendor]

@VId as int,
@COId as int,
@Vendor as nvarchar(50),
@Address as nvarchar(50),
@CellNo as nvarchar(50),
@OpBalance as nvarchar(50),
@Fax as nvarchar(50),
@Email as nvarchar(50),
@CAId as int

as

--Declare @IsExist as bit; 
--set @IsExist = 0;
--
--select @IsExist = VId from Vendor where Vendor = @Vendor 
--
--if @IsExist = 0
--begin
--
--Declare @PreOp decimal(18,2);
--set @PreOp = 0;
--
--select @PreOp = OpBalance from Vendor where VId = @VId
--
--update Vendor
--set
--
--Vendor =@Vendor,
--COId =@COId,
--Address =@Address,
--CellNo =@CellNo,
--OpBalance=@OpBalance,
--Fax=@Fax,
--Email=@Email,
--CAId = @CAId,
--PreOp = @PreOp
--
--where VId = @VId
--
--end
--
--select @IsExist;

Declare @IsExist as bit; 
set @IsExist = 0;
Declare @DbVendor as nvarchar(50); 
set @DbVendor = '0';
Declare @PreOp decimal(18,2);
set @PreOp = 0;

select @DbVendor = isnull(Vendor,'0') from Vendor where VId = @VId 
if @DbVendor = @Vendor
begin



select @PreOp = OpBalance from Vendor where VId = @VId

update Vendor
set

Vendor =@Vendor,
COId =@COId,
Address =@Address,
CellNo =@CellNo,
OpBalance=@OpBalance,
Fax=@Fax,
Email=@Email,
CAId = @CAId,
PreOp = @PreOp

where VId = @VId

end
else 
begin
select @IsExist = VId from Vendor where Vendor = @Vendor 

if @IsExist = 0
begin

select @PreOp = OpBalance from Vendor where VId = @VId

update Vendor
set

Vendor =@Vendor,
COId =@COId,
Address =@Address,
CellNo =@CellNo,
OpBalance=@OpBalance,
Fax=@Fax,
Email=@Email,
CAId = @CAId,
PreOp = @PreOp

where VId = @VId
end
end
select @IsExist









