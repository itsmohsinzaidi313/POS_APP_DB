CREATE TABLE [dbo].[Tables] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [tables]       NVARCHAR (50) NULL,
    [TableName]    NVARCHAR (50) NULL,
    [table_status] NVARCHAR (50) NULL,
    [TiltId]       INT           DEFAULT ((0)) NOT NULL,
    [CurrTiltId]   INT           DEFAULT ((0)) NOT NULL,
    [Is_upload]    BIT           DEFAULT ((0)) NOT NULL,
    [Is_update]    BIT           DEFAULT ((0)) NOT NULL
);

