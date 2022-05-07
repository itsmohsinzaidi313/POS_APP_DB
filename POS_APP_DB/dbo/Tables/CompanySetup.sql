CREATE TABLE [dbo].[CompanySetup] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (50)  NULL,
    [Address]      TEXT           NULL,
    [Phone1]       NVARCHAR (50)  NULL,
    [Fax]          NVARCHAR (50)  NULL,
    [Email]        NVARCHAR (50)  NULL,
    [Phone2]       NVARCHAR (50)  NULL,
    [Logo_]        NVARCHAR (MAX) NULL,
    [Logo]         IMAGE          NULL,
    [header]       BIT            NULL,
    [Logo2_]       NVARCHAR (MAX) NULL,
    [Logo2]        IMAGE          NULL,
    [ReportFooter] NVARCHAR (60)  NULL,
    [Company_id]   INT            DEFAULT ((0)) NOT NULL,
    [branch_id]    INT            DEFAULT ((0)) NOT NULL,
    [URL]          NVARCHAR (MAX) NULL,
    [Address2]     NVARCHAR (MAX) NULL,
    [EposURL]      NVARCHAR (100) NULL
);

