CREATE TABLE [dbo].[ItemConversion] (
    [id]                        INT        IDENTITY (1, 1) NOT NULL,
    [ItemId]                    INT        NULL,
    [Packing-InvUnitFactor]     FLOAT (53) NULL,
    [InvUnit-RecepieUnitFactor] FLOAT (53) NULL,
    CONSTRAINT [FK_ItemConversion_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

