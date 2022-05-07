CREATE TABLE [dbo].[AdvanceBookingDetail] (
    [id]               INT             IDENTITY (1, 1) NOT NULL,
    [AdvanceBookingId] INT             NOT NULL,
    [ItemId]           INT             NOT NULL,
    [Item]             NVARCHAR (50)   NOT NULL,
    [Qty]              DECIMAL (18, 2) NULL,
    [Rate]             DECIMAL (18, 2) NULL,
    [Amount]           DECIMAL (18, 2) NULL
);

