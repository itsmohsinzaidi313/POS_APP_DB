CREATE TABLE [dbo].[Company] (
    [COId]       INT           IDENTITY (1, 1) NOT NULL,
    [Company]    NVARCHAR (50) NULL,
    [IsSelected] BIT           CONSTRAINT [DF_Company_IsSelected] DEFAULT ((1)) NULL,
    [Address]    NVARCHAR (50) NULL,
    [ContactNo]  NVARCHAR (50) NULL,
    [Fax]        NVARCHAR (50) NULL,
    [Email]      NVARCHAR (50) NULL,
    [LogoName]   NVARCHAR (50) NULL,
    [Logo]       IMAGE         NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([COId] ASC)
);

