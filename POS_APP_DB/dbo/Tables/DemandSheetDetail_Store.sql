CREATE TABLE [dbo].[DemandSheetDetail_Store] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [DSCOId] INT             NULL,
    [ItemId] INT             NULL,
    [Unit]   INT             NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Status] BIT             CONSTRAINT [DF__DemandShe__Statu__24134F1B] DEFAULT ((0)) NULL,
    [POQty]  DECIMAL (18, 2) CONSTRAINT [DF_DemandSheetDetail_Store_POQty] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_DemandSheetDetail_Company_DemandSheetMaster_Company] FOREIGN KEY ([DSCOId]) REFERENCES [dbo].[DemandSheetMaster_Store] ([DSCOId]),
    CONSTRAINT [FK_DemandSheetDetail_Store_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);


GO
CREATE TRIGGER trgUpdateDemandSheetStatus ON dbo.DemandSheetDetail_Store
FOR UPDATE
AS
Declare @Id int;
set @Id = 0;
Declare @Qty as decimal(18,2);
set @Qty = 0;
Declare @POQty as decimal(18,2);
set @POQty = 0;

select @Id=i.id from inserted i; 

if (@Id > 0)
begin
select @Qty = Qty,@POQty = POQty from DemandSheetDetail_Store where id = @Id

if (@POQty >= @Qty)
begin
update DemandSheetDetail_Store set Status = 1 where id = @Id
end
else 
begin
update DemandSheetDetail_Store set Status = 0 where id = @Id

end
end
