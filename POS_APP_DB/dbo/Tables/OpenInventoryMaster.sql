CREATE TABLE [dbo].[OpenInventoryMaster] (
    [OpenInvId] INT           IDENTITY (1, 1) NOT NULL,
    [Date]      DATETIME      NULL,
    [Type]      NVARCHAR (50) NULL,
    CONSTRAINT [PK_OpenInventoryMaster] PRIMARY KEY CLUSTERED ([OpenInvId] ASC)
);

