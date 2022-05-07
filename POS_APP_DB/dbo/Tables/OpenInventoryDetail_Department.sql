CREATE TABLE [dbo].[OpenInventoryDetail_Department] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [OpenInvId] INT             NULL,
    [ItemId]    INT             NULL,
    [Qty]       DECIMAL (18, 2) NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [Amount]    DECIMAL (18, 2) NULL,
    [Unit]      INT             NULL
);

