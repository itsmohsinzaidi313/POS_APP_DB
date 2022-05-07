CREATE TABLE [dbo].[Customer] (
    [CustId]   INT            IDENTITY (1, 1) NOT NULL,
    [Customer] NVARCHAR (MAX) NULL,
    [Address]  NVARCHAR (MAX) NULL,
    [CellNo]   NVARCHAR (MAX) NULL,
    [CAId]     INT            NULL,
    [COId]     INT            NULL
);

