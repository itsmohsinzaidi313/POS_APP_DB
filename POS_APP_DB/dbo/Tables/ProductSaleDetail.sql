CREATE TABLE [dbo].[ProductSaleDetail] (
    [id]                  INT             IDENTITY (1, 1) NOT NULL,
    [PMID]                INT             NULL,
    [IngredientId]        INT             NULL,
    [PackingRatePerPcs]   DECIMAL (18, 2) NULL,
    [InventoryRatePerPcs] DECIMAL (18, 2) NULL,
    [RecipeRatePerPcs]    DECIMAL (18, 2) NULL,
    [IngredientQty]       DECIMAL (18, 4) NOT NULL,
    [IngredientAmount]    DECIMAL (18, 2) NULL
);

