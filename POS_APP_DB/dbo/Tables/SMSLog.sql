CREATE TABLE [dbo].[SMSLog] (
    [id]        INT            IDENTITY (1, 1) NOT NULL,
    [Order_Key] INT            NULL,
    [MobileNo]  NVARCHAR (50)  NULL,
    [Message]   NVARCHAR (MAX) NULL,
    [SentTime]  NVARCHAR (50)  NULL,
    [IsSent]    BIT            CONSTRAINT [DF_SMSLog_IsSent] DEFAULT ((0)) NULL
);

