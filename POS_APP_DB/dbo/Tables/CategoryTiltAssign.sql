CREATE TABLE [dbo].[CategoryTiltAssign] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [CategoryId] INT           NULL,
    [Tiltid]     INT           NULL,
    [OrderType]  NVARCHAR (50) NULL,
    [is_upload]  BIT           DEFAULT ((0)) NOT NULL,
    [is_update]  BIT           DEFAULT ((0)) NOT NULL
);

