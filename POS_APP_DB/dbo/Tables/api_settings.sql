CREATE TABLE [dbo].[api_settings] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [label]       VARCHAR (100) NOT NULL,
    [value]       VARCHAR (100) NOT NULL,
    [description] VARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

