CREATE TABLE [dbo].[AccountLevel] (
    [LevelId]     INT IDENTITY (1, 1) NOT NULL,
    [Level]       INT NOT NULL,
    [AccNoDigits] INT CONSTRAINT [DEF_AccountLevel_AccNoDigits] DEFAULT ((1)) NULL,
    [COId]        INT NULL,
    CONSTRAINT [PK_AccountLevel] PRIMARY KEY CLUSTERED ([LevelId] ASC)
);

