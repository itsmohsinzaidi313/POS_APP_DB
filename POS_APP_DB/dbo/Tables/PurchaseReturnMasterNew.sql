CREATE TABLE [dbo].[PurchaseReturnMasterNew] (
    [PRId]        INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [VId]         INT             NULL,
    [GRNId]       INT             NULL,
    [PRNo]        VARCHAR (50)    NULL,
    [SId]         INT             CONSTRAINT [DF_PurchaseReturnMasterNew_SId] DEFAULT ((0)) NULL,
    [BRId]        INT             CONSTRAINT [DF_PurchaseReturnMasterNew_BRId] DEFAULT ((0)) NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Discount]    DECIMAL (18, 2) NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [RefrenceNo]  NVARCHAR (50)   NULL,
    [TotalTax]    DECIMAL (18, 2) NULL,
    CONSTRAINT [PK__PurchaseReturnMasterNew_Aylant__3449B6E4] PRIMARY KEY CLUSTERED ([PRId] ASC),
    CONSTRAINT [FK_PurchaseReturnMasterNew_GRNMaster] FOREIGN KEY ([GRNId]) REFERENCES [dbo].[GRNMaster] ([GRNId]),
    CONSTRAINT [FK_PurchaseReturnMasterNew_Vendor1] FOREIGN KEY ([VId]) REFERENCES [dbo].[Vendor] ([VId])
);

