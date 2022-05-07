CREATE TABLE [dbo].[CashDrawer_Logging] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [User]      NVARCHAR (50) NOT NULL,
    [z_number]  NVARCHAR (50) NOT NULL,
    [TiltId]    INT           NOT NULL,
    [CounterId] INT           NOT NULL,
    [Date]      DATETIME      NOT NULL,
    [Time]      NVARCHAR (50) NOT NULL
);

