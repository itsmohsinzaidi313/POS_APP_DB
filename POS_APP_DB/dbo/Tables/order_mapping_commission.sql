CREATE TABLE [dbo].[order_mapping_commission] (
    [id]                INT          IDENTITY (1, 1) NOT NULL,
    [mapping_detail_id] INT          NULL,
    [commission]        DECIMAL (18) NULL,
    [status]            BIT          NOT NULL
);

