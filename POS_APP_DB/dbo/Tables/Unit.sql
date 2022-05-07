CREATE TABLE [dbo].[Unit] (
    [UId]  INT           IDENTITY (1, 1) NOT NULL,
    [Unit] NVARCHAR (50) NULL,
    CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED ([UId] ASC)
);

