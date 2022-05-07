CREATE TABLE [dbo].[2StepWok_Items_Temp] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [Order_Key]      NVARCHAR (50)   NOT NULL,
    [OrderDetail_Id] INT             NOT NULL,
    [Step_id]        INT             NOT NULL,
    [Step]           NCHAR (10)      NOT NULL,
    [Category_id]    INT             NOT NULL,
    [Category]       NVARCHAR (50)   NOT NULL,
    [Item_Id]        INT             NOT NULL,
    [Item]           NVARCHAR (50)   NOT NULL,
    [ItemQty]        DECIMAL (18, 2) NOT NULL
);

