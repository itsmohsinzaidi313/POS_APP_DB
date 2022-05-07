CREATE TABLE [dbo].[SMS_Setup] (
    [ID]       INT            IDENTITY (1, 1) NOT NULL,
    [UserID]   NVARCHAR (MAX) NOT NULL,
    [Password] NVARCHAR (MAX) NULL,
    [Mask]     NVARCHAR (MAX) NULL,
    [URL]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_SMS_Setup] PRIMARY KEY CLUSTERED ([ID] ASC)
);

