CREATE proc [dbo].[uspEndYear]

@To as datetime,
@COId as int,
@XML  XML
as

BEGIN TRY
   BEGIN TRANSACTION   

Declare @ApId int;
select @ApId = max(ApId) from AccountPeriod where IsActive = 1 

insert into AccountOpenBalance (Amount,CAId,APId) 
SELECT 
myXML.value('./@Balance', 'decimal(18,2)'), myXML.value('./@CAId', 'int'),0
FROM @XML.nodes('/doc/title') As nodes(myXML);
SET NOCOUNT OFF;
 
COMMIT

update AccountPeriod set IsActive = 0,[To] = @To where ApId = @ApId and COId = @COId

set @ApId = 0;

insert into AccountPeriod ([From],COId) values (DATEADD(day,1,@To),@COID)
select @ApId = Scope_Identity();

update AccountOpenBalance set ApId = @ApId where ApId = 0 

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH
