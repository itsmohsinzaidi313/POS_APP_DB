create proc [dbo].[uspInsertJV]

@VN as nvarchar(50),
@Date datetime,
@COId int,
@XML xml
as
BEGIN TRY
   BEGIN TRANSACTION  
DECLARE @JVId int;
Declare @Count int;
set @Count = 0;
insert into JVMaster
(
VN,
Date,
COId
)
values 
(
@VN,
@Date,
@COId
)
SET @JVId = SCOPE_IDENTITY();

if @JVID > 0
Begin

INSERT INTO JVDetail
    (
JVId,
Amount,
CAId,
[Type],
[Desc]
    )
SELECT 
@JVID,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int')
, myXML.value('./@Type', 'varchar(MAX)'),
          myXML.value('./@Desc', 'nvarchar(MAX)')
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End
COMMIT

Declare @APId int;
select @APId = max(APId) from AccountPeriod where IsActive = 1

INSERT INTO GL
    (
VN,
VoucherId,
Date,
COId,
[Type],
Amount,
CAId,
VoucherType,APId
    )
SELECT 
@VN,
@JVId,@Date,@COId,myXML.value('./@Type', 'varchar(MAX)'),
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int'),
         'JOURNAL VOUCHER',@APId
   FROM @XML.nodes('/doc/title') As nodes(myXML);
Select @Count = id from GL where VN = @VN and VoucherId = @JVId
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

Select @Count



--select * from gl where caid = 99


