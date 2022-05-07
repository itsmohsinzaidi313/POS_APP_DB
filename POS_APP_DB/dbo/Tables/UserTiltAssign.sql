CREATE TABLE [dbo].[UserTiltAssign] (
    [id]       INT IDENTITY (1, 1) NOT NULL,
    [UserId]   INT CONSTRAINT [DF_UserTiltAssign_UserId] DEFAULT ((0)) NULL,
    [Tiltid]   INT CONSTRAINT [DF_UserTiltAssign_Tiltid] DEFAULT ((0)) NULL,
    [WaiterId] INT CONSTRAINT [DF_UserTiltAssign_WaiterId] DEFAULT ((0)) NULL
);

