CREATE TABLE [dbo].[CategoryPOS] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [category_name] NVARCHAR (50)  NULL,
    [department]    NVARCHAR (50)  NULL,
    [TiltId]        INT            NULL,
    [Color]         NVARCHAR (50)  NULL,
    [IsComment]     BIT            CONSTRAINT [DF_CategoryPOS_IsComment] DEFAULT ((0)) NULL,
    [orderid]       INT            DEFAULT ((0)) NOT NULL,
    [GetType]       NVARCHAR (50)  NULL,
    [is_Discount]   BIT            DEFAULT ((0)) NOT NULL,
    [is_delete]     BIT            DEFAULT ((0)) NULL,
    [image_url]     NVARCHAR (MAX) NULL,
    [Is_upload]     BIT            DEFAULT ((0)) NOT NULL,
    [Is_update]     BIT            DEFAULT ((0)) NOT NULL,
    [is_tax_apply]  BIT            DEFAULT ((0)) NULL,
    [is_hnh]        BIT            DEFAULT ((0)) NULL,
    [sort]          INT            DEFAULT ((0)) NULL
);

