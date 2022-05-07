CREATE TABLE [dbo].[CashDrop] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [Z_Number]    NVARCHAR (50)   NULL,
    [Tiltid]      INT             NULL,
    [VoucherNo]   NVARCHAR (50)   NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [CareOf]      NVARCHAR (100)  NULL,
    [Description] NVARCHAR (MAX)  NULL,
    [CounterId]   INT             NULL,
    [User]        NVARCHAR (50)   NULL,
    [Time]        NVARCHAR (50)   NULL,
    [is_upload]   BIT             DEFAULT ((0)) NOT NULL,
    [is_update]   BIT             DEFAULT ((0)) NOT NULL
);

