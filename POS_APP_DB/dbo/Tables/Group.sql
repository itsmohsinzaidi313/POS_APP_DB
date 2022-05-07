CREATE TABLE [dbo].[Group] (
    [GRId]  INT           IDENTITY (1, 1) NOT NULL,
    [Group] NVARCHAR (50) NULL,
    [COId]  INT           NULL,
    CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED ([GRId] ASC)
);

