CREATE TABLE [dbo].[SubRecipeDetail] (
    [id]           INT        IDENTITY (1, 1) NOT NULL,
    [SubRecipeId]  INT        NULL,
    [IngredientId] INT        NULL,
    [Qty]          FLOAT (53) NULL,
    CONSTRAINT [FK_SubRecipeDetail_SubRecipeMaster] FOREIGN KEY ([SubRecipeId]) REFERENCES [dbo].[SubRecipeMaster] ([SubRecipeId])
);

