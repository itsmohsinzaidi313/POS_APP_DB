CREATE TABLE [dbo].[Order_Detail_ExtraItem_Temp] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [Order_Detail_Id] INT             NOT NULL,
    [Extra_ItemId]    INT             NOT NULL,
    [Extra_Item]      NVARCHAR (50)   NOT NULL,
    [Price]           DECIMAL (18, 2) DEFAULT ((0)) NOT NULL
);

