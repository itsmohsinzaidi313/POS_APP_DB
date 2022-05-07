CREATE TABLE [dbo].[tblLuckyDraw] (
    [id]        INT          IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (50) NOT NULL,
    [from]      INT          NULL,
    [to]        INT          NULL,
    [IsActive]  BIT          NOT NULL,
    [Date]      DATETIME     NULL,
    [Increment] INT          NULL
);

