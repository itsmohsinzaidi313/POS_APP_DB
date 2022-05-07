


CREATE proc [dbo].[InsertParLevel]
@XML as xml
as
insert into ItemParlevel
(
ItemId,
Parlevel,
BRId,
SId
)

Select

myXML.value('./@ItemId','int'),
myXML.value('./@Parlevel','decimal(18,2)'),
'0',
myXML.value('./@SId','int')

FROM @XML.nodes('/doc/title') As nodes(myXML);
SET NOCOUNT OFF;




--select * from ItemParlevel