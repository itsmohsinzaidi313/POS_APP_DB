CREATE TABLE [dbo].[UserTypeAccess] (
    [UserTypeAccessId] INT           IDENTITY (1, 1) NOT NULL,
    [Functions]        NVARCHAR (50) NULL,
    [UTId]             INT           NULL,
    [IsActive]         BIT           CONSTRAINT [DF_UserTypeAccess_IsActive] DEFAULT ((1)) NULL,
    CONSTRAINT [FK_UserTypeAccess_UserType] FOREIGN KEY ([UTId]) REFERENCES [dbo].[UserType] ([UTId])
);

