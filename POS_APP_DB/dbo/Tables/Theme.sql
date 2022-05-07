CREATE TABLE [dbo].[Theme] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [form_name]  NVARCHAR (50) NULL,
    [theme_name] NVARCHAR (50) NULL,
    CONSTRAINT [PK_Theme] PRIMARY KEY CLUSTERED ([id] ASC)
);

