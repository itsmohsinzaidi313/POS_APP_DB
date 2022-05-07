CREATE TABLE [dbo].[POS_Default_Settings] (
    [shift_operation] BIT           NOT NULL,
    [company_name]    NVARCHAR (50) NULL,
    [franchise_name]  NVARCHAR (50) NULL,
    [opening_report]  BIT           NULL,
    [closing_report]  BIT           NULL,
    [no_of_z_report]  INT           NULL,
    [phone_no]        NVARCHAR (50) NULL,
    [branch_id]       NVARCHAR (50) NULL
);

