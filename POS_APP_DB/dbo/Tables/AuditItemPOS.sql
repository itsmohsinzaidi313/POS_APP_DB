CREATE TABLE [dbo].[AuditItemPOS] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [category_name] NVARCHAR (50)  NULL,
    [item_name]     NVARCHAR (250) NULL,
    [cost_price]    FLOAT (53)     NULL,
    [sale_price]    FLOAT (53)     NULL,
    [codes]         NVARCHAR (250) NULL,
    [status]        BIT            CONSTRAINT [DF_AuditItemPOS_status] DEFAULT ((1)) NOT NULL,
    [tiltId]        INT            NULL,
    [IsComment]     BIT            CONSTRAINT [DF_AuditItemPOS_IsComment] DEFAULT ((0)) NULL,
    [Date]          DATETIME       NULL,
    [User]          NVARCHAR (100) NULL
);

