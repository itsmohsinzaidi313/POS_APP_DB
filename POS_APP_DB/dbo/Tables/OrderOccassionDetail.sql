CREATE TABLE [dbo].[OrderOccassionDetail] (
    [OccassionId]       INT            IDENTITY (1, 1) NOT NULL,
    [OrderNo]           NVARCHAR (50)  NULL,
    [OccasionDate]      DATETIME       NULL,
    [OccasionTime]      NVARCHAR (50)  NULL,
    [Destination]       NVARCHAR (50)  NULL,
    [NoOfPersons]       NVARCHAR (50)  NULL,
    [ItemId]            INT            NULL,
    [TotalAmount]       FLOAT (53)     NULL,
    [OccassionOfPerson] FLOAT (53)     NULL,
    [MenuDetail]        NVARCHAR (MAX) NULL,
    [Occassion]         NVARCHAR (50)  NULL
);

