CREATE TABLE [dbo].[KDS_Department_IP_Setting] (
    [id]     INT           IDENTITY (1, 1) NOT NULL,
    [Did]    INT           NOT NULL,
    [KDSIP]  NVARCHAR (50) NOT NULL,
    [TiltID] INT           NULL
);

