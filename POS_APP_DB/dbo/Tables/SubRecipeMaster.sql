CREATE TABLE [dbo].[SubRecipeMaster] (
    [SubRecipeId]     INT             IDENTITY (1, 1) NOT NULL,
    [ProductId]       INT             NULL,
    [max_FP_Cost]     DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [min_SP_Price]    DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Current_FP_Cost] DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Comments]        NVARCHAR (MAX)  NULL,
    [isSale]          BIT             DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SubRecipeMaster] PRIMARY KEY CLUSTERED ([SubRecipeId] ASC)
);

