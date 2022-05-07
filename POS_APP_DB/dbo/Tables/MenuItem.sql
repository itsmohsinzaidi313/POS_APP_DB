CREATE TABLE [dbo].[MenuItem] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [CategoryId] INT           NULL,
    [Item]       NVARCHAR (50) NULL,
    [Cover]      INT           NULL,
    [Price]      FLOAT (53)    NULL,
    [IsOpen]     BIT           CONSTRAINT [DF_MenuItem_IsOpen] DEFAULT ((0)) NULL
);

