CREATE TABLE [dbo].[DemandSheetMaster_Branch] (
    [DSId]   INT            IDENTITY (1, 1) NOT NULL,
    [BRId]   INT            NULL,
    [Date]   DATETIME       NULL,
    [DSNo]   VARCHAR (50)   NULL,
    [UserId] INT            NULL,
    [DId]    INT            CONSTRAINT [DF_DemandSheetMaster_Branch_DId] DEFAULT ((0)) NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([DSId] ASC),
    CONSTRAINT [FK_DemandSheetMaster_Branch_Branch] FOREIGN KEY ([BRId]) REFERENCES [dbo].[Branch] ([BRId])
);

