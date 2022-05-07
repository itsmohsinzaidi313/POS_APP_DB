CREATE TABLE [dbo].[ProductionDetailDepartment] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [PRId]       INT             NULL,
    [ItemId]     INT             NULL,
    [UnitId]     INT             NULL,
    [Qty]        DECIMAL (18, 2) NULL,
    [RatePerPcs] DECIMAL (18, 2) NULL
);

