CREATE TABLE [dbo].[WareHouse_Branch] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [Date]      DATETIME        NULL,
    [ItemId]    INT             NULL,
    [Unit]      INT             NULL,
    [InvoiceId] INT             CONSTRAINT [DF_WareHouse_Branch_InvoiceId] DEFAULT ((0)) NULL,
    [IssId]     INT             CONSTRAINT [DF_WareHouse_Branch_IssId] DEFAULT ((0)) NULL,
    [TRInId]    INT             CONSTRAINT [DF_WareHouse_Branch_TRInId] DEFAULT ((0)) NULL,
    [TROutId]   INT             CONSTRAINT [DF_WareHouse_Branch_TROutId] DEFAULT ((0)) NULL,
    [InvAdjId]  INT             CONSTRAINT [DF_WareHouse_Branch_InvAdjId] DEFAULT ((0)) NULL,
    [Qty]       DECIMAL (18, 4) NOT NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [Type]      VARCHAR (50)    NULL,
    [BRId]      INT             NULL,
    [IssRTId]   INT             CONSTRAINT [DF_WareHouse_Branch_IssRTId] DEFAULT ((0)) NULL,
    [SId]       INT             CONSTRAINT [DF_WareHouse_Branch_SId] DEFAULT ((0)) NULL,
    [PDId]      INT             CONSTRAINT [DF_WareHouse_Branch_PDId] DEFAULT ((0)) NULL,
    [PMId]      INT             CONSTRAINT [DF_WareHouse_Branch_PMId] DEFAULT ((0)) NULL,
    [Desc]      NVARCHAR (50)   NULL,
    [DId]       INT             CONSTRAINT [DF_WareHouse_Branch_DId] DEFAULT ((0)) NULL,
    [Amount]    DECIMAL (18, 2) CONSTRAINT [DF_WareHouse_Branch_Amount] DEFAULT ((0)) NULL,
    [OpenInvId] INT             DEFAULT ((0)) NOT NULL,
    [Qty_Pcs]   DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [FK_WareHouse_Branch_Branch] FOREIGN KEY ([BRId]) REFERENCES [dbo].[Branch] ([BRId]),
    CONSTRAINT [FK_WareHouse_Branch_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);


GO
CREATE TRIGGER [dbo].[InsertWarehouseBranchDesc] ON dbo.WareHouse_Branch
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @Id int;
Declare @InvoiceId int;
Declare @IssId int;
Declare @TRInId int;
Declare @TROutId int;
Declare @InvAdjId int;
Declare @IssRTId int;
Declare @PdId int;
Declare @PMId int;
Declare @TransType nvarchar(50);
set @Id = 0;
set @InvoiceId = 0;
set @IssId = 0;
set @TRInId = 0;
set @TROutId = 0;
set @InvAdjId = 0;
set @IssRTId = 0;
set @PdId = 0;
set @PMId =0;
set @TransType = '0';
select 
 @Id = id,
 @InvoiceId = InvoiceId,
 @IssId = IssId,
 @TRInId = TRInId,
 @TROutId = TROutId,
 @InvAdjId = InvAdjId,
@IssRTId = IssRTId,
 @PdId = PDId,
@PMId = PMId

 from WareHouse_Branch
where id = (select max(id) from WareHouse_Branch)

--if @Id > 0
--Begin

if @InvoiceId > 0
Begin
set @TransType = 'Purchase';
Update WareHouse_Branch set [Desc] = @TransType where InvoiceId = @InvoiceId

End
else if @IssId > 0
Begin
set @TransType = 'Issuance';
Update WareHouse_Branch set [Desc] = @TransType where IssId = @IssId

End
else if @TRInId > 0
Begin
set @TransType = 'TransferIn';
Update WareHouse_Branch set [Desc] = @TransType where TRInId = @TRInId

End
else if @TROutId > 0
Begin
set @TransType = 'TransferOut';
Update WareHouse_Branch set [Desc] = @TransType where TROutId = @TROutId

End
else if @InvAdjId > 0
Begin
set @TransType = 'InvAdj';
Update WareHouse_Branch set [Desc] = @TransType where InvAdjId = @InvAdjId

End
else if @IssRTId > 0
Begin
set @TransType = 'IssuanceRT';
Update WareHouse_Branch set [Desc] = @TransType where IssRTId = @IssRTId

End
else if @PMId > 0
Begin
set @TransType = 'Sale';
Update WareHouse_Branch set [Desc] = @TransType where PMId = @PMId

End

else if @PdId > 0
Begin
set @TransType = 'Production';
Update WareHouse_Branch set [Desc] = @TransType where PdId = @PdId

End

End
