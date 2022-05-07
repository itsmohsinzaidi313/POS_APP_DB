CREATE TABLE [dbo].[User] (
    [UserId]   INT            IDENTITY (1, 1) NOT NULL,
    [UserName] NVARCHAR (MAX) NULL,
    [Password] NVARCHAR (MAX) NULL,
    [UTId]     INT            NULL,
    CONSTRAINT [FK_User_UserType] FOREIGN KEY ([UTId]) REFERENCES [dbo].[UserType] ([UTId])
);

