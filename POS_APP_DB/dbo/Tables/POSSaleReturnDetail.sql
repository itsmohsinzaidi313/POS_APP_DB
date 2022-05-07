CREATE TABLE [dbo].[POSSaleReturnDetail] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [Sid]             INT            NULL,
    [item_name]       NVARCHAR (50)  NULL,
    [qty]             FLOAT (53)     NULL,
    [price]           FLOAT (53)     NULL,
    [Category]        NVARCHAR (50)  NULL,
    [DealDescription] NVARCHAR (MAX) NULL,
    [is_upload]       BIT            DEFAULT ((0)) NOT NULL,
    [is_update]       BIT            DEFAULT ((0)) NOT NULL,
    [unique_key]      VARCHAR (50)   NULL
);

