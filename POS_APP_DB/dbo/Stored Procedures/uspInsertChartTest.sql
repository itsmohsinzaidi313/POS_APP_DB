
--select * from AccountNature
--[uspInsertChartTest]'','CURRENT ASSETS','ASSETS','GROUP',1,'',1,0
--[uspInsertChartTest]'CURRENT ASSETS','CASH BALANCES','ASSETS','GROUP',2,'',1,0
--[uspInsertChartTest]'CASH BALANCES','CASH IN HAND','ASSETS','DETAIL',3,'',1,0
--[uspInsertChartTest]'CASH BALANCES','COUNTER CASH','ASSETS','DETAIL',3,'',1,0
--[uspInsertChartTest]'CASH BALANCES','SHOP CASH','ASSETS','DETAIL',3,'',1,0
--[uspInsertChartTest]'CURRENT ASSETS','BANK BALANCES','ASSETS','GROUP',2,'',1,0
--[uspInsertChartTest]'CURRENT ASSETS','DEBIT CARD BALANCES','ASSETS','GROUP',2,'',1,0
--[uspInsertChartTest]'DEBIT CARD BALANCES','MEEZAN DEBIT CARD','ASSETS','DETAIL',3,'',1,0
--[uspInsertChartTest]'DEBIT CARD BALANCES','HBL DEBIT CARD','ASSETS','DETAIL',3,'',1,0
--[uspInsertChartTest]'','FIX ASSETS','ASSETS','GROUP',1,'',1,0
--[uspInsertChartTest]'FIX ASSETS','BUILDINGS','ASSETS','GROUP',2,'',1,0
--[uspInsertChartTest]'BUILDINGS','KAMRAN HOUSE','ASSETS','DETAIL',3,'',1,0

--select * from ChartOfAccount

create proc [dbo].[uspInsertChartTest]
@Group nvarchar(50),
@AccName nvarchar(50),
@AccNature nvarchar(50),
@Type nvarchar(50),
@Level int,
@Desc text,
@COId int,
@OpenBalance decimal(18,2)

as

BEGIN TRY
   BEGIN TRANSACTION   

DECLARE @AccNo INT;
DECLARE @PrevLevel INT;
DECLARE @AccNoDigits INT;
DECLARE @ParentId INT;
DECLARE @StrLen INT;
DECLARE @StrAccNo VARCHAR(10);
DECLARE @intFlag INT;
DECLARE @Diff int;
DECLARE @CAId int;
DECLARE @PrevAccNo VARCHAR(10);
DECLARE @PrevAccNoDigits INT;
DECLARE @CurrAccNoDigits INT;


set @AccNo = 0;
set @PrevAccNo = '0';
set @ParentId = 0;
SET @PrevLevel = @Level - 1;
select @CurrAccNoDigits = AccNoDigits from AccountLevel where [Level] = @Level
select @PrevAccNoDigits = isnull(AccNoDigits,0) from AccountLevel where [Level] = @PrevLevel
set @AccNoDigits = @CurrAccNoDigits - @PrevAccNoDigits;
select @ParentId = ISNULL(CAId,0) from ChartOfAccount where AccName = @Group
select @PrevAccNo = Cast(isnull(max(AccNo),0) as VARCHAR(10)) from ChartOfAccount where [Level] = @PrevLevel and AccName = @Group and AccNature = @AccNature

--if @PrevLevel = 0
--Begin
select @AccNo = CAST(isnull(max(AccNo),0)as int) from ChartOfAccount where [Level] = @Level and ParentId = @ParentId and AccNature = @AccNature

if @AccNo > 0
Begin
set @AccNo = @AccNo + 1;
set @StrAccNo = CAST(@AccNo AS VARCHAR(10))

End
else 
Begin
set @AccNo = @AccNo + 1;
set @StrAccNo = CAST(@AccNo AS VARCHAR(10))
set @StrLen = LEN(@StrAccNo) 

if @StrLen < @AccNoDigits
Begin
SET @intFlag = 1
SET @Diff = @AccNoDigits - @StrLen

WHILE (@intFlag <= @Diff)
BEGIN

SET @StrAccNo = '0' + @StrAccNo

SET @intFlag = @intFlag + 1
END
END
SET @StrAccNo = @PrevAccNo + @StrAccNo 

if @Level = 1 
Begin
Declare @AccNatureNo int;
Declare @Temp int;
set @Temp = cast(@StrAccNo as int);
select @AccNatureNo = AccNo from AccountNature where Account = @AccNature
set @StrAccNo = cast(@AccNatureNo as nvarchar(50)) + cast(@Temp as nvarchar(50));
End





End

--select @StrAccNo,
--@AccName ,
--@AccNature,
--@Type ,
--@Level ,
--@ParentId,
--@Desc,
--@COId,@PrevAccNo,@ParentId
--




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
@StrAccNo,
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
--select * from AccountNature

