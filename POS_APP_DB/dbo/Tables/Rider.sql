CREATE TABLE [dbo].[Rider] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [RiderId]   INT             CONSTRAINT [DF_Rider_RiderId] DEFAULT ((0)) NULL,
    [name]      NVARCHAR (50)   NULL,
    [Commision] DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [IsPercent] BIT             DEFAULT ((0)) NOT NULL
);

