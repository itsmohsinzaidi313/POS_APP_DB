CREATE TABLE [dbo].[questions_feedback] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [feedback_id] INT           NOT NULL,
    [question]    VARCHAR (300) NOT NULL,
    [answer]      VARCHAR (100) NOT NULL,
    CONSTRAINT [PK__question__3213E83F728F82EA] PRIMARY KEY CLUSTERED ([id] ASC)
);

