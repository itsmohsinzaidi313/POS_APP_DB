CREATE TABLE [dbo].[CustomerLedgerAdvBooking] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [VoucherId]       INT             NULL,
    [Amount]          DECIMAL (18, 2) NULL,
    [Type]            VARCHAR (40)    NULL,
    [CustId]          INT             NULL,
    [Date]            DATETIME        NULL,
    [VoucherType]     NVARCHAR (50)   NULL,
    [VN]              NVARCHAR (50)   NULL,
    [BuffetBookingId] INT             NULL,
    [TiltId]          INT             CONSTRAINT [DF_CustomerLedgerAdvBooking_TiltId] DEFAULT ((0)) NULL,
    [CounterId]       INT             CONSTRAINT [DF_CustomerLedgerAdvBooking_CounterId] DEFAULT ((0)) NULL,
    [ShiftNo]         NVARCHAR (50)   NULL,
    [OpId]            INT             CONSTRAINT [DF_CustomerLedgerAdvBooking_OpId] DEFAULT ((0)) NULL,
    [UserReceived]    NVARCHAR (500)  NULL,
    [status]          BIT             DEFAULT ((0)) NULL,
    [Od]              NVARCHAR (50)   NULL,
    [is_upload]       BIT             DEFAULT ((0)) NOT NULL,
    [is_update]       BIT             DEFAULT ((0)) NOT NULL,
    [time]            NVARCHAR (50)   NULL,
    [Date_time]       DATETIME        NULL
);

