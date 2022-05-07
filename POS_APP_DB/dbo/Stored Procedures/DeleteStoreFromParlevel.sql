Create Proc [dbo].[DeleteStoreFromParlevel]
@SId as int
as
delete from ItemParlevel

where SId=@SId