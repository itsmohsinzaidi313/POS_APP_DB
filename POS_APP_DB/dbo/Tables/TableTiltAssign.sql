CREATE TABLE [dbo].[TableTiltAssign] (
    [id]      INT IDENTITY (1, 1) NOT NULL,
    [TableId] INT NULL,
    [Tiltid]  INT NULL,
    [Active]  INT CONSTRAINT [DF_TableTiltAssign_Active] DEFAULT ((1)) NULL
);

