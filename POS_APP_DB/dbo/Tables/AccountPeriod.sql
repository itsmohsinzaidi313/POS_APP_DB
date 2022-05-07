CREATE TABLE [dbo].[AccountPeriod] (
    [ApId]     INT      IDENTITY (1, 1) NOT NULL,
    [From]     DATETIME NULL,
    [To]       DATETIME NULL,
    [COId]     INT      NULL,
    [IsActive] BIT      CONSTRAINT [DEF_AccountPeriod_IsActive] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_AccountPeriod] PRIMARY KEY CLUSTERED ([ApId] ASC)
);

