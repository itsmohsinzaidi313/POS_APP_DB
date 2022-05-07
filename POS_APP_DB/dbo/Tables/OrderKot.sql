CREATE TABLE [dbo].[OrderKot] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [OrderKey]        NVARCHAR (50)  NULL,
    [ItemId]          INT            NULL,
    [Qty]             FLOAT (53)     NULL,
    [KotStatus]       BIT            CONSTRAINT [DF_OrderKot_KotStatus] DEFAULT ((0)) NULL,
    [Comments]        NVARCHAR (50)  NULL,
    [Tiltid]          INT            NULL,
    [ItemComment]     NVARCHAR (MAX) NOT NULL,
    [LessReason]      NVARCHAR (MAX) NULL,
    [OrderDetailId]   INT            DEFAULT ((0)) NOT NULL,
    [OrderKey_Merege] NVARCHAR (50)  NULL,
    [kotFromtablet]   BIT            DEFAULT ((0)) NOT NULL,
    [tabkot]          BIT            DEFAULT ((0)) NOT NULL,
    [IsKDS]           BIT            DEFAULT ((0)) NOT NULL,
    [IsDispathed]     BIT            DEFAULT ((0)) NOT NULL,
    [Order_type]      NVARCHAR (50)  NULL,
    [is_print]        BIT            DEFAULT ((0)) NULL,
    [Is_KDS]          BIT            DEFAULT ((0)) NULL
);

