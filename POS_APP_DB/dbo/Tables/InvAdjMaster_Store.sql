CREATE TABLE [dbo].[InvAdjMaster_Store] (
    [AdjId]     INT            IDENTITY (1, 1) NOT NULL,
    [Date]      DATETIME       NULL,
    [UserId]    INT            NULL,
    [SId]       INT            NULL,
    [IsApprove] BIT            NULL,
    [AdjNo]     VARCHAR (50)   NULL,
    [AppById]   INT            CONSTRAINT [DF_InvAdjMaster_Store_AppById] DEFAULT ((0)) NULL,
    [Desc]      NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([AdjId] ASC),
    CONSTRAINT [FK_InvAdjMaster_Store_Store] FOREIGN KEY ([SId]) REFERENCES [dbo].[Store] ([SId])
);

