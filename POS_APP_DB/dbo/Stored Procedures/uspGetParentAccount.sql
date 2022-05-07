create proc [dbo].[uspGetParentAccount]

@AccNature as nvarchar(50),
@Level as int,
@COId as int
as
Declare @PrevLevel int;
set @PrevLevel = @Level - 1;
select CAId,AccName from ChartOfAccount 
where AccNature = @AccNature and [Level] = @PrevLevel and COId = @COId


