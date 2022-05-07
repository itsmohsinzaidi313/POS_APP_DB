CREATE TABLE [dbo].[RecipeDetail] (
    [id]           INT        IDENTITY (1, 1) NOT NULL,
    [RecipeId]     INT        NULL,
    [IngredientId] INT        NULL,
    [Qty]          FLOAT (53) NULL,
    [IsSubRecipe]  BIT        CONSTRAINT [DF_RecipeDetail_IsSubRecipe] DEFAULT ((0)) NULL,
    [is_DineIn]    BIT        DEFAULT ((0)) NULL,
    [Is_TakeAway]  BIT        DEFAULT ((0)) NULL,
    [Is_Delivery]  BIT        DEFAULT ((0)) NULL,
    CONSTRAINT [FK_RecipeDetail_Item] FOREIGN KEY ([IngredientId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_RecipeDetail_RecipeMaster] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[RecipeMaster] ([RecipeId])
);

