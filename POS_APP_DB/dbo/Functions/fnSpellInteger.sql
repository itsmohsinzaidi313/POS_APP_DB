
CREATE FUNCTION [dbo].[fnSpellInteger] ( @number int )
RETURNS VARCHAR(100)
AS
BEGIN
	-- For debugging outside of the UDF: DECLARE @debug bit  SET @debug = 0

	DECLARE @result VARCHAR(100), @word VARCHAR(100), @group VARCHAR(100)
	DECLARE @i int, @j int, @m int, @digit VARCHAR(2), @cn VARCHAR(20)

	IF @number = 0 RETURN 'Zero'

	SELECT @result = '', @word = '', @group = ''
	
	SET @cn = @number
	SET @cn = REPLACE(@cn,',','')
	SET @m = LEN(@cn) % 3 
	IF @m > 0 SET @cn = REPLICATE('0',3-@m) + @cn				-- Left pad with zeroes to a multiple of 3

	SET @i = 1
	SET @j = LEN(@cn)-@i+1
	SET @m = @i % 3
	WHILE @i <= LEN(@cn)
	BEGIN
		-- @i is 1 origin index into numeric string while @m = @i modulo 3
		-- If the middle digit of each group of 3 is a '1' then this is a 'Ten' or a '...teen'
		IF @m = 2 AND SUBSTRING(@cn,@i,1) = '1' 
		BEGIN
			SET @digit = SUBSTRING(@cn,@i,2)
			-- Skip rightmost digit of 3 if processing teens 
			SET @i = @i + 1
		END
		ELSE 
			SET @digit = SUBSTRING(@cn,@i,1)

		SET @word = 
		CASE 
			WHEN @m = 0 THEN									-- Rightmost digit of group of 3
				CASE @digit 
					WHEN '0' THEN ''
					WHEN '1' THEN 'One'
					WHEN '2' THEN 'Two'
					WHEN '3' THEN 'Three'
					WHEN '4' THEN 'Four'
					WHEN '5' THEN 'Five'
					WHEN '6' THEN 'Six'
					WHEN '7' THEN 'Seven'
					WHEN '8' THEN 'Eight'
					WHEN '9' THEN 'Nine'
				END + 
				CASE 
					WHEN (@group <> '' OR @digit <> '0') AND (@j+2) / 3 = 2 THEN ' Thousand'
					WHEN (@group <> '' OR @digit <> '0') AND (@j+2) / 3 = 3 THEN ' Million'
					WHEN (@group <> '' OR @digit <> '0') AND (@j+2) / 3 = 4 THEN ' Billion'
					ELSE ''
				END
			WHEN LEN(@digit) = 2 THEN							-- Special case when middle digit is a '1'
				CASE @digit 
					WHEN '10' THEN 'Ten'
					WHEN '11' THEN 'Eleven'
					WHEN '12' THEN 'Twelve'
					WHEN '13' THEN 'Thirteen'
					WHEN '14' THEN 'Fourteen'
					WHEN '15' THEN 'Fifteen'
					WHEN '16' THEN 'Sixteen'
					WHEN '17' THEN 'Seventeen'
					WHEN '18' THEN 'Eighteen'
					WHEN '19' THEN 'Nineteen'
				END +
				CASE 
					WHEN (@group <> '' OR @digit <> '00') AND (@j+2) / 3 = 2 THEN ' Thousand'
					WHEN (@group <> '' OR @digit <> '00') AND (@j+2) / 3 = 3 THEN ' Million'
					WHEN (@group <> '' OR @digit <> '00') AND (@j+2) / 3 = 4 THEN ' Billion'
					ELSE ''
				END
			WHEN @m = 2 THEN									-- Middle digit of group of 3
				CASE @digit 
					WHEN '2' THEN 'Twenty'
					WHEN '3' THEN 'Thirty'
					WHEN '4' THEN 'Forty'
					WHEN '5' THEN 'Fifty'
					WHEN '6' THEN 'Sixty'
					WHEN '7' THEN 'Seventy'
					WHEN '8' THEN 'Eighty'
					WHEN '9' THEN 'Ninety'
					ELSE ''
				END
			WHEN @m = 1 THEN									-- Leftmost digit of group of 3
				CASE @digit 
					WHEN '0' THEN ''
					WHEN '1' THEN 'One'
					WHEN '2' THEN 'Two'
					WHEN '3' THEN 'Three'
					WHEN '4' THEN 'Four'
					WHEN '5' THEN 'Five'
					WHEN '6' THEN 'Six'
					WHEN '7' THEN 'Seven'
					WHEN '8' THEN 'Eight'
					WHEN '9' THEN 'Nine'
				END + 
				CASE WHEN @digit <> '0' THEN ' Hundred' ELSE '' END
		END

		SET @group = @group + RTRIM(@word)						-- Group value

		IF @word <> '' 
		BEGIN
			DECLARE @prefix VARCHAR(20)
			IF CHARINDEX(' ',@word) > 0 SET @prefix = LEFT(@word,CHARINDEX(' ',@word)) ELSE SET @prefix = @word 
			IF RIGHT(@result,2) = 'ty' AND @prefix IN ('One','Two','Three','Four','Five','Six','Seven','Eight','Nine')
				SET @result = @result + '-' + LTRIM(@word) 
			ELSE
				SET @result = @result + ' ' + LTRIM(@word) 
		END
		-- The following needs to be outside of a UDF to work:
		--IF @debug = 1 SELECT @cn as 'Number', @i as '@i', @j as '@j', @m as '@m', @digit as '@digit', CAST(replace(@group,' ','`') AS CHAR(30)) as '@group', @word as '@word', @result as '@result'
		SET @i = @i + 1
		SET @j = LEN(@cn)-@i+1
		SET @m = @i % 3 
		IF @m = 1 SET @group = ''								-- Clear group value when starting a new one

	END

	IF @result = '' SET @result = '0'
	RETURN LTRIM(@Result)

END
