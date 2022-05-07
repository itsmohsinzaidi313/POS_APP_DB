CREATE TABLE [dbo].[Item_Delete] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [order_key]  NVARCHAR (50) NULL,
    [order_num]  NVARCHAR (50) NULL,
    [date]       DATETIME      NULL,
    [z_num]      NVARCHAR (50) NULL,
    [operator]   NVARCHAR (50) NULL,
    [category]   NVARCHAR (50) NULL,
    [item]       NVARCHAR (50) NULL,
    [qty]        FLOAT (53)    NULL,
    [price]      FLOAT (53)    NULL,
    [waiter]     NVARCHAR (50) NULL,
    [order_type] NVARCHAR (50) NULL,
    [status]     NVARCHAR (50) NULL,
    [shift]      NVARCHAR (50) NULL,
    [tiltId]     INT           NULL,
    [CounterId]  INT           NULL,
    [Status1]    BIT           DEFAULT ((0)) NOT NULL,
    [is_upload]  BIT           DEFAULT ((0)) NOT NULL,
    [is_update]  BIT           DEFAULT ((0)) NOT NULL,
    [unique_key] VARCHAR (50)  NULL
);

