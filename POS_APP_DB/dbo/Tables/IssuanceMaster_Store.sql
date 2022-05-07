CREATE TABLE [dbo].[IssuanceMaster_Store] (
    [IssId]  INT            IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME       NULL,
    [SId]    INT            NULL,
    [BRId]   INT            NULL,
    [UserId] INT            NULL,
    [Type]   VARCHAR (50)   NULL,
    [IssNo]  VARCHAR (50)   NULL,
    [DSId]   INT            NULL,
    [PSId]   INT            CONSTRAINT [DF_IssuanceMaster_Store_PSId] DEFAULT ((0)) NULL,
    [DId]    INT            CONSTRAINT [DF_IssuanceMaster_Store_DId] DEFAULT ((0)) NULL,
    [GRNId]  INT            CONSTRAINT [DF_IssuanceMaster_Store_GRNId] DEFAULT ((0)) NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([IssId] ASC)
);

