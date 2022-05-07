CREATE TABLE [dbo].[CategoryMenu] (
    [id]   INT IDENTITY (1, 1) NOT NULL,
    [Menu] BIT CONSTRAINT [DF_CategoryMenu_Menu] DEFAULT ((0)) NULL
);

