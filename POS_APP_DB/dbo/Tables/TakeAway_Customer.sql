CREATE TABLE [dbo].[TakeAway_Customer] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [customer]  NVARCHAR (50) NULL,
    [phone_num] NVARCHAR (50) NULL,
    [order_key] NVARCHAR (50) NULL
);

