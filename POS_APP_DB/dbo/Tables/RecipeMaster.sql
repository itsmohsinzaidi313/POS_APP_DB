CREATE TABLE [dbo].[RecipeMaster] (
    [RecipeId]        INT             IDENTITY (1, 1) NOT NULL,
    [ProductId]       INT             NULL,
    [max_FP_Cost]     DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [min_SP_Price]    DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Current_FP_Cost] DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Comments]        NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_RecipeMaster] PRIMARY KEY CLUSTERED ([RecipeId] ASC)
);

