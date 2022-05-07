CREATE TABLE [dbo].[Ent] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [order_key] NVARCHAR (50) NULL,
    [order_num] NVARCHAR (50) NULL,
    [date]      DATETIME      NULL,
    [name]      NVARCHAR (50) NULL,
    [c_o]       NVARCHAR (50) NULL,
    [z_num]     NVARCHAR (50) NULL,
    [Tiltid]    INT           NULL,
    [CounterId] INT           NULL,
    [is_upload] BIT           DEFAULT ((0)) NOT NULL,
    [is_update] BIT           DEFAULT ((0)) NOT NULL
);

