create function [dbo].[funcCalculateConsumption]
(
@Balance decimal(18,2),
@PhyStock decimal(18,2)
)
returns decimal(18,2)
as
Begin

Declare @Consumption decimal(18,2);
set @Consumption =0;

set @Consumption = @Balance - @PhyStock  

return @Consumption 
End




