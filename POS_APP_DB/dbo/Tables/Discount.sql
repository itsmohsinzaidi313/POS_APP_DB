CREATE TABLE [dbo].[Discount] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [date]         DATETIME      NULL,
    [order_key]    NVARCHAR (50) NULL,
    [order_num]    NVARCHAR (50) NULL,
    [c_o]          NVARCHAR (50) NULL,
    [payment_type] NVARCHAR (50) NULL,
    [order_type]   NVARCHAR (50) NULL,
    [discount]     FLOAT (53)    NULL,
    [percent]      NVARCHAR (50) NULL,
    [z_num]        NVARCHAR (50) NULL,
    [order_price]  FLOAT (53)    NULL,
    [Tiltid]       INT           NULL,
    [CounterId]    INT           NULL,
    [Status]       BIT           DEFAULT ((0)) NOT NULL,
    [is_upload]    BIT           DEFAULT ((0)) NOT NULL,
    [is_update]    BIT           DEFAULT ((0)) NOT NULL
);

