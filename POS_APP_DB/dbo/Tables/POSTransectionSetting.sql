CREATE TABLE [dbo].[POSTransectionSetting] (
    [id]     INT           IDENTITY (1, 1) NOT NULL,
    [type]   NVARCHAR (50) NULL,
    [status] BIT           CONSTRAINT [DF_POSTransectionSetting_status] DEFAULT ((0)) NULL
);

