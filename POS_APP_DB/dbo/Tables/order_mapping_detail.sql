CREATE TABLE [dbo].[order_mapping_detail] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [discount_name] NVARCHAR (50) NULL,
    [enable]        BIT           NULL,
    [is_receivable] BIT           NULL,
    [master_id]     INT           NULL,
    [display]       VARCHAR (50)  NULL
);

