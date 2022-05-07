CREATE TABLE [dbo].[UnitConversion] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [UnitFrom]   NVARCHAR (50)   NULL,
    [UnitTo]     NVARCHAR (50)   NULL,
    [Conversion] DECIMAL (18, 2) NULL
);

