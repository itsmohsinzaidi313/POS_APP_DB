CREATE TABLE [dbo].[PosSale] (
    [id]      INT           IDENTITY (1, 1) NOT NULL,
    [z_num]   NVARCHAR (50) NULL,
    [Date]    DATETIME      NULL,
    [Amount]  FLOAT (53)    NULL,
    [Type]    NVARCHAR (50) NULL,
    [VN]      NVARCHAR (50) NULL,
    [Desc]    TEXT          NULL,
    [Account] NVARCHAR (50) NULL
);

