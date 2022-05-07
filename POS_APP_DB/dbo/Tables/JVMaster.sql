CREATE TABLE [dbo].[JVMaster] (
    [JVId] INT           IDENTITY (1, 1) NOT NULL,
    [VN]   NVARCHAR (40) NULL,
    [Date] DATETIME      NULL,
    [COId] INT           NULL,
    CONSTRAINT [PK_JVMaster] PRIMARY KEY CLUSTERED ([JVId] ASC)
);

