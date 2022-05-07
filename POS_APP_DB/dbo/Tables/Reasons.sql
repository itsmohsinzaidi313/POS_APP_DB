CREATE TABLE [dbo].[Reasons] (
    [id]        INT            IDENTITY (1, 1) NOT NULL,
    [Reason]    NVARCHAR (MAX) NOT NULL,
    [is_upload] BIT            DEFAULT ((0)) NOT NULL,
    [is_update] BIT            DEFAULT ((0)) NOT NULL
);

