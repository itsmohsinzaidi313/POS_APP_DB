create proc [dbo].[UspInsertItemUnit]

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

insert into ItemUnit
(

ItemId ,
PkUnit ,
PkFactor ,
PurUnit ,
PurFactor ,
IssUnit ,
IssFactor ,
RecpUnit,
RecpFactor 
)
Values
(
@ItemId ,
@PkUnit ,
@PkFactor ,
@PurUnit ,
@PurFactor ,
@IssUnit ,
@IssFactor ,
@RecpUnit,
@RecpFactor 
)

