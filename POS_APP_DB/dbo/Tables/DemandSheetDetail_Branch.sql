CREATE TABLE [dbo].[DemandSheetDetail_Branch] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [DSId]   INT             NULL,
    [ItemId] INT             NULL,
    [Unit]   VARCHAR (50)    NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Status] BIT             CONSTRAINT [DF_DemandSheetDetail_Branch_Status] DEFAULT ((0)) NULL,
    [IssQty] DECIMAL (18, 2) CONSTRAINT [DF_DemandSheetDetail_Branch_IssQty] DEFAULT ((0)) NULL
);


GO
create TRIGGER [trgDemadOrderKitchenStatus] ON [dbo].[DemandSheetDetail_Branch]
FOR UPDATE
AS
Declare @Id int;
set @Id = 0;
Declare @Qty as decimal(18,2);
set @Qty = 0;
Declare @IssQty as decimal(18,2);
set @IssQty = 0;

select @Id=i.id from inserted i; 

if (@Id > 0)
begin
select @Qty = Qty,@IssQty = IssQty from DemandSheetDetail_Branch where id = @Id

if (@IssQty >= @Qty)
begin
update DemandSheetDetail_Branch set Status = 1 where id = @Id
end
else 
begin
update DemandSheetDetail_Branch set Status = 0 where id = @Id

end
end






