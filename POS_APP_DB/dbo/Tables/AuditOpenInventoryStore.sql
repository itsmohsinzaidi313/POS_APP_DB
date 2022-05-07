CREATE TABLE [dbo].[AuditOpenInventoryStore] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME        NULL,
    [ItemId] INT             NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Rate]   DECIMAL (18, 2) NULL,
    [Amount] DECIMAL (18, 2) NULL,
    [Unitid] INT             NULL
);

