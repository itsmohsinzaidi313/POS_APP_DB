CREATE TABLE [dbo].[PurchaseOrderMaster_Store] (
    [POId]   INT            IDENTITY (0, 1) NOT NULL,
    [Date]   DATETIME       NULL,
    [COId]   INT            NULL,
    [PONo]   VARCHAR (50)   NULL,
    [VId]    INT            NULL,
    [Status] BIT            CONSTRAINT [DF__PurchaseO__Statu__26EFBBC6] DEFAULT ((0)) NULL,
    [UserId] INT            NULL,
    [SId]    INT            NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK__PurchaseOrderMas__25FB978D] PRIMARY KEY CLUSTERED ([POId] ASC),
    CONSTRAINT [FK_PurchaseOrderMaster_Store_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId]),
    CONSTRAINT [FK_PurchaseOrderMaster_Store_Store] FOREIGN KEY ([SId]) REFERENCES [dbo].[Store] ([SId]),
    CONSTRAINT [FK_PurchaseOrderMaster_Store_Vendor] FOREIGN KEY ([VId]) REFERENCES [dbo].[Vendor] ([VId])
);

