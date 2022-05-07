CREATE TABLE [dbo].[OrderServedTime] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [OrderType]     NVARCHAR (50) NULL,
    [ServedTime]    INT           NULL,
    [DeliveredTime] INT           DEFAULT ((0)) NULL
);

