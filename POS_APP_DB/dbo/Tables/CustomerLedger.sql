CREATE TABLE [dbo].[CustomerLedger] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [VoucherId]       INT             NULL,
    [Amount]          DECIMAL (18, 2) NULL,
    [Type]            VARCHAR (40)    NULL,
    [CustId]          INT             NULL,
    [Date]            DATETIME        NULL,
    [COId]            INT             NULL,
    [VoucherType]     NVARCHAR (50)   NULL,
    [VN]              NVARCHAR (50)   NULL,
    [SaleId]          INT             NULL,
    [date_time]       DATETIME        NULL,
    [Time]            NVARCHAR (50)   NULL,
    [BuffetBookingId] INT             NULL,
    [TiltId]          INT             NULL,
    [CounterId]       INT             NULL,
    [ShiftNo]         NVARCHAR (50)   NULL,
    [OpId]            INT             NULL,
    [UserReceived]    NVARCHAR (50)   NULL
);

