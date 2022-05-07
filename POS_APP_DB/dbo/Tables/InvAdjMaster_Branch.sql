CREATE TABLE [dbo].[InvAdjMaster_Branch] (
    [AdjBRId]   INT            IDENTITY (1, 1) NOT NULL,
    [Date]      DATETIME       NULL,
    [UserId]    INT            NULL,
    [BRId]      INT            NULL,
    [IsApprove] BIT            NULL,
    [AdjNo]     VARCHAR (50)   NULL,
    [AppById]   INT            CONSTRAINT [DF_InvAdjMaster_Branch_AppById] DEFAULT ((0)) NULL,
    [DId]       INT            CONSTRAINT [DF_InvAdjMaster_Branch_DId] DEFAULT ((0)) NULL,
    [Desc]      NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([AdjBRId] ASC),
    CONSTRAINT [FK_InvAdjMaster_Branch_Branch] FOREIGN KEY ([BRId]) REFERENCES [dbo].[Branch] ([BRId])
);

