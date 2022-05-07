CREATE TABLE [dbo].[VoucherDetail] (
    [id]            INT             IDENTITY (1, 1) NOT NULL,
    [Order_key]     NVARCHAR (50)   NULL,
    [VoucherName]   NVARCHAR (500)  NULL,
    [VoucherQty]    FLOAT (53)      NULL,
    [VoucherAmount] DECIMAL (18, 2) NULL,
    [VoucherSerial] NVARCHAR (MAX)  NULL
);

