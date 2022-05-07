CREATE TABLE [dbo].[JVDetail] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [Amount] DECIMAL (18, 2) NULL,
    [CAId]   INT             NULL,
    [Type]   VARCHAR (40)    NULL,
    [Desc]   NVARCHAR (MAX)  NULL,
    [JVId]   INT             NULL,
    CONSTRAINT [JVMaster_JVDetail] FOREIGN KEY ([JVId]) REFERENCES [dbo].[JVMaster] ([JVId]) ON DELETE CASCADE
);

