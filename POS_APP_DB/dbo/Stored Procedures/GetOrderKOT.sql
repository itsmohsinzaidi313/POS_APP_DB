CREATE Proc [dbo].[GetOrderKOT]
@OrderKey as nvarchar(50),
@TiltId as int

as
select * from OrderKot where orderkey =@OrderKey and KotStatus = 'False' and TiltId=@TiltId

