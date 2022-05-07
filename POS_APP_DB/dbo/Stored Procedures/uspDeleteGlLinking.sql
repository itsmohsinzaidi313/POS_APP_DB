create proc [dbo].[uspDeleteGlLinking]
@Id as int
as
delete from DiscountMapping where Id = @Id