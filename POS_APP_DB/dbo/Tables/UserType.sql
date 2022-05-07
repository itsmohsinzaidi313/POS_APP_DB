CREATE TABLE [dbo].[UserType] (
    [UTId]     INT           IDENTITY (1, 1) NOT NULL,
    [UserType] NVARCHAR (50) NULL,
    [COId]     INT           NULL,
    CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED ([UTId] ASC)
);

