
SELECT
	title AS adtitle,

--count the number of words in the title
	LENGTH(title) - LENGTH(REPLACE(title, ' ', '')) + 1 AS ad_title_word_length,

--analyse the punctuation of a title
	CASE
		WHEN LEFT (title,1) IN ('1', '2' ,'3' ,'4','5','6','7','8','9') THEN 'starts with a number'

		WHEN INSTR(title, '-') !=0 THEN 'contains a dash'
		WHEN INSTR(title, ':') !=0 THEN 'contains a colon'
		WHEN INSTR(title, ',') !=0 THEN 'contains a comma'
		WHEN INSTR(title, '"') !=0 THEN 'contains quoatation marks'

		WHEN RIGHT(title,1) = '!' THEN 'ends with an exclamation mark'
		WHEN RIGHT(title,1) = '?' THEN 'ends with a question mark'
		WHEN RIGHT(title, 1) = '.' THEN 'ends with a dot'
		WHEN RIGHT(title,1) NOT IN ('?', '!', '.') then 'ends with no punctuation'
		WHEN RIGHT(title,1) IN ('1', '2' ,'3' ,'4','5','6','7','8','9') then 'ends with a number'
	END AS ad_punctuation,


--find tge number of characters and classify according to the following criteria	
	LENGTH(title) AS title_char_length,
	CASE
		WHEN LENGTH(title) < 40 THEN '0-40 characters'
		WHEN LENGTH(title) >= 40 AND LENGTH(title) < 70 THEN '40-70 charcaters'
		WHEN LENGTH(title) >= 70 THEN 'more than 70 characters'
	END AS ad_title_charength,

---find the number of Upper case characters in the string
	REGEXP_COUNT(title, '[A-Z]') AS number_of_upper_case_charactersin_title,

FROM tbl_titles
