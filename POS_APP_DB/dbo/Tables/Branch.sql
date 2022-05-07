CREATE TABLE [dbo].[Branch] (
    [BRId]                 INT            IDENTITY (1, 1) NOT NULL,
    [COId]                 INT            NULL,
    [Branch]               NVARCHAR (50)  NULL,
    [IsSelected]           BIT            CONSTRAINT [DF_Branch_IsSelected] DEFAULT ((1)) NULL,
    [IsPosSelected]        BIT            NULL,
    [last_internet_update] NVARCHAR (100) NULL,
    CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED ([BRId] ASC),
    CONSTRAINT [FK_Branch_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId])
);

