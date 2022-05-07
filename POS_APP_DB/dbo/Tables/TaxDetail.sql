CREATE TABLE [dbo].[TaxDetail] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [Order_Key]  NVARCHAR (50)   NULL,
    [TaxName]    NVARCHAR (50)   NULL,
    [TaxType]    NVARCHAR (50)   NULL,
    [TaxPercent] NVARCHAR (50)   NULL,
    [TaxAmount]  DECIMAL (18, 2) NULL,
    [is_upload]  BIT             DEFAULT ((0)) NOT NULL,
    [is_update]  BIT             DEFAULT ((0)) NOT NULL
);

