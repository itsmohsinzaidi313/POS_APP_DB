CREATE TABLE [dbo].[DeliveryCharges] (
    [id]               INT             IDENTITY (1, 1) NOT NULL,
    [IsActive]         BIT             CONSTRAINT [DF_Delivery_IsActive] DEFAULT ((0)) NOT NULL,
    [isPercent]        BIT             CONSTRAINT [DF_Delivery_isPercent] DEFAULT ((0)) NOT NULL,
    [Delivery Charges] DECIMAL (18, 2) CONSTRAINT [DF_Delivery_Delivery Charges] DEFAULT ((0)) NOT NULL,
    [Apply On Amount]  DECIMAL (18, 2) CONSTRAINT [DF_Delivery_Apply On Amount] DEFAULT ((0)) NOT NULL
);

