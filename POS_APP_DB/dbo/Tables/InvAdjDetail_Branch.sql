CREATE TABLE [dbo].[InvAdjDetail_Branch] (
    [id]      INT             IDENTITY (1, 1) NOT NULL,
    [AdjBRId] INT             NULL,
    [ItemId]  INT             NULL,
    [Unit]    INT             NULL,
    [Qty]     DECIMAL (18, 2) NULL,
    [Rate]    DECIMAL (18, 2) NULL,
    [Type]    NVARCHAR (50)   NULL
);

