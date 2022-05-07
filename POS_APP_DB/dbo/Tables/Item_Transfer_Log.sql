CREATE TABLE [dbo].[Item_Transfer_Log] (
    [id]                INT             IDENTITY (1, 1) NOT NULL,
    [Date]              DATETIME        NOT NULL,
    [Z_Number]          NVARCHAR (50)   NOT NULL,
    [Order_Key_To]      NVARCHAR (50)   NOT NULL,
    [Order_Key_From]    NVARCHAR (50)   NOT NULL,
    [Tiltid]            INT             NOT NULL,
    [Counter_Id]        INT             NOT NULL,
    [Loginuser]         NVARCHAR (50)   NOT NULL,
    [Authenticate_User] NVARCHAR (50)   NOT NULL,
    [ItemId]            INT             NOT NULL,
    [Qty]               DECIMAL (18, 2) NOT NULL
);

