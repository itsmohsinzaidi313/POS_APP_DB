CREATE TABLE [dbo].[ProductionDetail] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [PRId]       INT             NULL,
    [ItemId]     INT             NULL,
    [UnitId]     INT             NULL,
    [Qty]        DECIMAL (18, 2) NULL,
    [RatePerPcs] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_ProductionDetail_ProductionMaster] FOREIGN KEY ([PRId]) REFERENCES [dbo].[ProductionMaster] ([PRId])
);

