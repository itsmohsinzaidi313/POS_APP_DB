create proc [dbo].[uspInsertChatOfAccountManual]

@Group nvarchar(50),
@AccName nvarchar(50),
@AccNature nvarchar(50),
@Type nvarchar(50),
@Level int,
@Desc text,
@COId int,
@OpenBalance decimal(18,2),
@AccNo as int

as

BEGIN TRY
   BEGIN TRANSACTION   

DECLARE @CAId int;
set @CAId = 0;
DECLARE @ParentId INT;
set @ParentId = 0;

select @ParentId = ISNULL(CAId,0) from ChartOfAccount where AccName = @Group

insert into ChartOfAccount
(
AccNo,
AccName,
AccNature,
[Type],
[Level],
ParentId,
[Desc],
COId,
Op

)
values 
(
@AccNo,
@AccName ,
@AccNature,
@Type ,
@Level ,
@ParentId,
@Desc,
@COId,
@OpenBalance
)
set @CAId = SCOPE_IDENTITY();

COMMIT

--if @Type = 'DETAIL'
--Begin
--
--Declare @FiscalYearId int;
--select @FiscalYearId = APId from AccountPeriod where COId = @COId and IsActive = 1
--
--insert into AccountOpenBalance 
--(
--Amount,
--CAId,
--APId
--)
--values 
--(
--@OpenBalance,
--@CAId,
--@FiscalYearId
--)
--End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH
select @CAId



