create proc [dbo].[UspUpdateItemUnit]

@id as int,
@ItemId as int,
@PkUnit as nvarchar(50),
@PkFactor nvarchar(50),
@PurUnit nvarchar(50),
@PurFactor nvarchar(50),
@IssUnit nvarchar(50),
@IssFactor as decimal(18,2),
@RecpUnit nvarchar(50),
@RecpFactor as decimal(18,2)

as

update ItemUnit
set
ItemId =@ItemId,
PkUnit= @PkUnit,
PkFactor= @PkFactor,
PurUnit =@PurUnit,
PurFactor =@PurFactor,
IssUnit=@IssUnit ,
IssFactor= @IssFactor,
RecpUnit=@RecpUnit,
RecpFactor=@RecpFactor 

where id = @id

