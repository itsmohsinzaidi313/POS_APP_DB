CREATE TABLE [dbo].[DeploymentDetail] (
    [ID]   INT      IDENTITY (1, 1) NOT NULL,
    [Date] DATETIME NOT NULL,
    CONSTRAINT [PK_DeploymentDetail] PRIMARY KEY CLUSTERED ([ID] ASC)
);

