CREATE TABLE [dbo].[Tax] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [isApplicable] BIT           NULL,
    [tax_type]     NVARCHAR (50) NULL,
    [tax_amount]   FLOAT (53)    NULL,
    [Tax]          NCHAR (50)    NULL,
    [is_upload]    BIT           DEFAULT ((0)) NOT NULL,
    [is_update]    BIT           DEFAULT ((0)) NOT NULL
);

