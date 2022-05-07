CREATE TABLE [dbo].[CustomerReciptDetail] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [CustRId]         INT             NULL,
    [Amount]          DECIMAL (18, 2) NULL,
    [Desc]            NVARCHAR (MAX)  NULL,
    [BuffetBookingId] INT             NULL,
    [is_upload]       BIT             DEFAULT ((0)) NOT NULL,
    [is_update]       BIT             DEFAULT ((0)) NOT NULL
);

