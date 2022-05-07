create proc [dbo].[uspGetAccountByLevelParentIdTypeAccNature]
@Level as int,
@ParentId as int,
@Type as nvarchar(50),
@AccNature as nvarchar(50),
@COId as int
as
select CAId,AccName from chartofaccount 
--where [Level] = 1 and ParentId = 0 and [Type] = 'GROUP' and AccNature = 'ASSETS'
where [Level] = @Level and ParentId = @ParentId and [Type] = @Type and AccNature = @AccNature
and COId = @COId
