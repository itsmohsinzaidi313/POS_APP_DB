CREATE TABLE [dbo].[CustomerPOS_] (
    [id]                INT            IDENTITY (1, 1) NOT NULL,
    [order_key]         NVARCHAR (50)  NULL,
    [customer_name]     NVARCHAR (50)  NULL,
    [address]           NVARCHAR (500) NULL,
    [tel_no]            NVARCHAR (50)  NULL,
    [cell_no]           NVARCHAR (50)  NULL,
    [CustomerCode]      NVARCHAR (500) NULL,
    [Active]            INT            DEFAULT ((1)) NOT NULL,
    [Address2]          NVARCHAR (500) NULL,
    [customer_group_id] INT            DEFAULT ((0)) NOT NULL
);

