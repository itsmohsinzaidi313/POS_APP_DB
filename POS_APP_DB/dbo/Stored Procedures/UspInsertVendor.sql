
CREATE proc [dbo].[UspInsertVendor]

@COId as int ,
@Vendor as nvarchar(50),
@Address as nvarchar(50),
@CellNo as nvarchar(50),
@OpBalance as nvarchar(50),
@Fax as nvarchar(50),
@Email as nvarchar(50),
@CAId as int 

as
Declare @VId as  int;
set @VId=0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = VId from Vendor where Vendor = @Vendor 

if @IsExist = 0
begin

insert into Vendor
(
COId,
Vendor ,
Address ,
CellNo ,
OpBalance,
Fax,
Email,
CAId
)
Values
(
@COId,
@Vendor ,
@Address ,
@CellNo ,
@OpBalance,
@Fax,
@Email,
@CAId
)

select @VId = scope_identity();
end

select @VId;