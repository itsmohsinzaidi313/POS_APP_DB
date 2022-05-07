CREATE TABLE [dbo].[LoginStatus] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [User]        NVARCHAR (100) NULL,
    [Type]        NVARCHAR (50)  NULL,
    [Description] NVARCHAR (50)  NULL,
    [Date]        DATETIME       NULL,
    [Time]        NVARCHAR (50)  NULL
);

