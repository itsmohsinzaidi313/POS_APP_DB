CREATE TABLE [dbo].[OrderStatusTime] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [Order_Key]     INT           NULL,
    [BookTime]      NVARCHAR (50) NULL,
    [AssignTime]    NVARCHAR (50) NULL,
    [AssambleTime]  NVARCHAR (50) NULL,
    [DispatchTime]  NVARCHAR (50) NULL,
    [CompleteTime]  NVARCHAR (50) NULL,
    [DeliveredTime] NVARCHAR (50) DEFAULT ((0)) NULL
);

