CREATE TABLE [dbo].[Shift_Opening] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [opening_date]    DATETIME      NULL,
    [opening_day]     NVARCHAR (50) NULL,
    [shift_name]      NVARCHAR (50) NULL,
    [z_report_number] NVARCHAR (50) NULL,
    [opening_person]  NVARCHAR (50) NULL,
    [closing_person]  NVARCHAR (50) NULL,
    [opening_time]    NVARCHAR (50) NULL,
    [closing_time]    NVARCHAR (50) NULL,
    [status]          BIT           NULL,
    [tiltid]          INT           NULL,
    [is_upload]       BIT           DEFAULT ((0)) NOT NULL,
    [is_update]       BIT           DEFAULT ((0)) NOT NULL
);

