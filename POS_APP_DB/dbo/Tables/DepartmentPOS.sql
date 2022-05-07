CREATE TABLE [dbo].[DepartmentPOS] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [department_name] NVARCHAR (50) NULL,
    [BRId]            INT           CONSTRAINT [DF_DepartmentPOS_BRId] DEFAULT ((0)) NULL,
    [COId]            INT           CONSTRAINT [DF_DepartmentPOS_COId] DEFAULT ((0)) NULL,
    [Is_upload]       BIT           DEFAULT ((0)) NOT NULL,
    [Is_update]       BIT           DEFAULT ((0)) NOT NULL
);

