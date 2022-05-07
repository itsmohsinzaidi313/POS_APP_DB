CREATE TABLE [dbo].[feedback] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [order_key]        INT           NOT NULL,
    [customer_name]    VARCHAR (200) NOT NULL,
    [customer_contact] VARCHAR (200) NOT NULL,
    [remarks]          VARCHAR (MAX) NULL,
    [date]             DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

