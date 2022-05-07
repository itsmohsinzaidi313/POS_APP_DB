create proc [dbo].[UspUpdateCustomer]

@COId as int ,
@Vendor as nvarchar(50),
@Address as nvarchar(50),
@CellNo as nvarchar(50),
@CustId as int,
@CAId as int

as



update Customer set 

COId=@COId,

Customer =@Vendor ,

Address =@Address ,

CellNo =@CellNo ,

CAId = @CAId

where CustId = @CustId








