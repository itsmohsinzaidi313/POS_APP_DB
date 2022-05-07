CREATE TABLE [dbo].[ItemComments] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [ItemComments] NVARCHAR (MAX) NULL,
    [Item]         NVARCHAR (50)  NULL,
    [is_upload]    BIT            DEFAULT ((0)) NOT NULL,
    [is_update]    BIT            DEFAULT ((0)) NOT NULL
);

