CREATE TABLE [dbo].[order_feedback] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [feedback_id] INT           NOT NULL,
    [item_name]   VARCHAR (300) NOT NULL,
    [rating]      INT           NOT NULL,
    CONSTRAINT [PK__order_fe__3213E83F9F45A6D1] PRIMARY KEY CLUSTERED ([id] ASC)
);

