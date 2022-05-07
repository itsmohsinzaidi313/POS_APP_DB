CREATE FUNCTION [dbo].[udf_choise_to_number]
(
	@choice varchar(20)
)
RETURNS INT
AS
BEGIN
	RETURN
	CASE 
		WHEN @choice =  'Single Item' THEN 0
		WHEN @choice = 'Choose Any One' THEN 1
		WHEN @choice = 'Choose Any Two' THEN 2
		WHEN @choice = 'Choose Any Three' THEN 3
		WHEN @choice = 'Choose Any Four' THEN 4
		WHEN @choice = 'Choose Any Five' THEN 5
		WHEN @choice = 'Choose Any Six' THEN 6
		WHEN @choice = 'Choose Any Seven' THEN 7
		WHEN @choice = 'Choose Any Eight' THEN 8
		WHEN @choice = 'Choose Any Nine' THEN 9
		WHEN @choice = 'Choose Any Ten' THEN 10
		WHEN @choice = 'Choose Any Eleven' THEN 11
		WHEN @choice = 'Choose Any Twelve' THEN 12
		WHEN @choice = 'Choose Any Thirteen' THEN 13
		WHEN @choice = 'Choose Any Fourteen' THEN 14
		WHEN @choice = 'Choose Any Fifteen' THEN 15
		WHEN @choice = 'Choose Any Sixteen' THEN 16
		WHEN @choice = 'Choose Any Seventeen' THEN 17
		WHEN @choice = 'Choose Any Eighteen' THEN 18
		WHEN @choice = 'Choose Any Nineteen' THEN 19
		WHEN @choice = 'Choose Any Twenty' THEN 20
		ELSE 21 END
END
