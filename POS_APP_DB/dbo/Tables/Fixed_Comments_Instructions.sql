CREATE TABLE [dbo].[Fixed_Comments_Instructions] (
    [id]        INT            IDENTITY (1, 1) NOT NULL,
    [Comments]  NVARCHAR (MAX) NULL,
    [is_upload] BIT            DEFAULT ((0)) NOT NULL,
    [is_update] BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Fixed_Comments_Instructions] PRIMARY KEY CLUSTERED ([id] ASC)
);

