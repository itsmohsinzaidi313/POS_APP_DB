CREATE TABLE [dbo].[Waiter] (
    [id]          INT             NULL,
    [waiter_name] NVARCHAR (50)   NULL,
    [Tiltid]      INT             DEFAULT ((0)) NOT NULL,
    [id_]         INT             IDENTITY (1, 1) NOT NULL,
    [commission]  DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [is_percent]  BIT             DEFAULT ((0)) NOT NULL,
    [Is_upload]   BIT             DEFAULT ((0)) NOT NULL,
    [Is_update]   BIT             DEFAULT ((0)) NOT NULL
);

