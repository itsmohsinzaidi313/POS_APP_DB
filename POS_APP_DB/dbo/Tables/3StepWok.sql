CREATE TABLE [dbo].[3StepWok] (
    [id]          INT        IDENTITY (1, 1) NOT NULL,
    [Step_id]     INT        NOT NULL,
    [Step]        NCHAR (10) NOT NULL,
    [Category_id] INT        NOT NULL,
    [Item_Id]     INT        NOT NULL
);

