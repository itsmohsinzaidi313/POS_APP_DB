CREATE TABLE [dbo].[ItemPOS_Assign] (
    [ID]             INT IDENTITY (1, 1) NOT NULL,
    [Item_ID]        INT NULL,
    [Item_Finish_ID] INT NULL,
    CONSTRAINT [PK_ItemPOS_Assign] PRIMARY KEY CLUSTERED ([ID] ASC)
);

