
select * 
from ['Movies Raw_Data$']

-- STEP # 1 /*CLEANING THE YEAR COLUMN*/ 
-- Our objective is to get the release year of the movie

select distinct(LEN(year)) as length
from ['Movies Raw_Data$']
order by length

-- There are 15 values for the length of records in the year column (NULL,3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 17, 18, 20) 

select year
from ['Movies Raw_Data$']
where year is null
order by YEAR

select year
from ['Movies Raw_Data$']
where LEN(year) = 3
order by YEAR

select year
from ['Movies Raw_Data$']
where LEN(year) = 4
order by YEAR

-- Deleting null values and expressions such as (I) and (II) in the year column

Delete 
from
['Movies Raw_Data$']
where LEN(year) = 3 or LEN(year) = 4 or year is null

-- For length = 5

select distinct(year)
from ['Movies Raw_Data$']
where LEN(year) = 5
order by YEAR

Delete 
from ['Movies Raw_Data$']
where year = '(III)' or YEAR = '(VII)' or YEAR = '(XII)' or YEAR = '(XLI)'

select substring(year,2,4)
from ['Movies Raw_Data$']
where LEN(year) = 5
Order by YEAR

Update ['Movies Raw_Data$']
set YEAR = substring(year,2,4)
from ['Movies Raw_Data$']
where LEN(year) = 5

-- Where length of Year = 6

select Distinct(year)
from ['Movies Raw_Data$']
where LEN(year) = 6
order by YEAR

Delete 
from
['Movies Raw_Data$']
where LEN(year) = 6

-- Where Length of Year = 7
select Distinct(YEAR)
From ['Movies Raw_Data$']
Where LEN(year) = 7
Order By YEAR

Delete 
from
['Movies Raw_Data$']
where LEN(year) = 7

-- Where Length of Year = 10
select distinct(year)
from ['Movies Raw_Data$']
where LEN(year) = 10
order by YEAR

Delete 
from ['Movies Raw_Data$']
where Year = '(TV Movie)'

Select Substring(year,6,4) 
from ['Movies Raw_Data$']
where year = '(I) (2000)' or year = '(I) (2004)' or year = '(I) (2005)' or year = '(I) (2008)' or year = '(I) (2009)'
	or year = '(I) (2010)' or year = '(I) (2011)' or year = '(I) (2012)' or year = '(I) (2013)' or year = '(I) (2014)'
	or year = '(I) (2015)' or year = '(I) (2016)' or year = '(I) (2017)' or year = '(I) (2018)' or year = '(I) (2019)'
	or year = '(I) (2020)' or year = '(I) (2021)' or year = '(V) (2010)' or year = '(V) (2016)' or year = '(V) (2018)'

update ['Movies Raw_Data$']
Set YEAR = Substring(year,6,4) 
from ['Movies Raw_Data$']
where year = '(I) (2000)' or year = '(I) (2004)' or year = '(I) (2005)' or year = '(I) (2008)' or year = '(I) (2009)'
	or year = '(I) (2010)' or year = '(I) (2011)' or year = '(I) (2012)' or year = '(I) (2013)' or year = '(I) (2014)'
	or year = '(I) (2015)' or year = '(I) (2016)' or year = '(I) (2017)' or year = '(I) (2018)' or year = '(I) (2019)'
	or year = '(I) (2020)' or year = '(I) (2021)' or year = '(V) (2010)' or year = '(V) (2016)' or year = '(V) (2018)'

select substring(year,2,4)
from ['Movies Raw_Data$']
where LEN(year) = 10
order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = substring(year,2,4)
from ['Movies Raw_Data$']
where LEN(year) = 10

-- For lenght = 11
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 11
order by YEAR

select Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 11
order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 11

-- Where length(year)= 12
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 12
order by YEAR

Delete
from ['Movies Raw_Data$']
where YEAR = '(TV Special)'

Select Substring(year,8,4)
from ['Movies Raw_Data$']
where year = '(III) (2010)' or year = '(III) (2011)'or year = '(III) (2012)'or year = '(III) (2014)'or year =
	'(III) (2015)'or year = '(III) (2016)'or year = '(III) (2017)'or year = '(III) (2018)'or year = '(III) (2019)'
	or year = '(III) (2020)'or year = '(III) (2021)'or year = '(XIV) (2017)'
Order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = Substring(year,8,4)
from ['Movies Raw_Data$']
where year = '(III) (2010)' or year = '(III) (2011)'or year = '(III) (2012)'or year = '(III) (2014)'or year =
	'(III) (2015)'or year = '(III) (2016)'or year = '(III) (2017)'or year = '(III) (2018)'or year = '(III) (2019)'
	or year = '(III) (2020)'or year = '(III) (2021)'or year = '(XIV) (2017)'

select SUBSTRING(year, 2, 4)
from ['Movies Raw_Data$']
where Len(year) = 12
order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = SUBSTRING(year, 2, 4)
from ['Movies Raw_Data$']
where Len(year) = 12

--Where lenght(Year) = 13

Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 13
order by YEAR

Select Substring(year, 2,4)
from ['Movies Raw_Data$']
where Len(year) = 13
order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = Substring(year, 2,4)
from ['Movies Raw_Data$']
where Len(year) = 13

--Where lenght(Year) = 14
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 14
order by YEAR

Select Substring(year, 6,4)
from ['Movies Raw_Data$']
where Len(year) = 14
order by YEAR

Update ['Movies Raw_Data$']
Set YEAR = Substring(year, 6,4)
from ['Movies Raw_Data$']
where Len(year) = 14

--Where lenght(Year) = 15
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 15
order by YEAR

Select substring(year, 7,4)
from ['Movies Raw_Data$']
where year = '(II) (2007â€“ )' 
	or Year = '(II) (2012â€“ )'
	or Year = '(II) (2016â€“ )'
	or Year = '(II) (2017â€“ )'
	or Year = '(II) (2019â€“ )'
	or Year = '(II) (2020â€“ )'
	or Year = '(II) (2021â€“ )'
order by YEAR

Update ['Movies Raw_Data$']
set Year = substring(year, 7,4)
from ['Movies Raw_Data$']
where year = '(II) (2007â€“ )' 
	or Year = '(II) (2012â€“ )'
	or Year = '(II) (2016â€“ )'
	or Year = '(II) (2017â€“ )'
	or Year = '(II) (2019â€“ )'
	or Year = '(II) (2020â€“ )'
	or Year = '(II) (2021â€“ )'

Select substring(year, 2,4)
from ['Movies Raw_Data$']
where len(year) = 15
order by YEAR

Update ['Movies Raw_Data$']
set Year = substring(year, 2,4)
from ['Movies Raw_Data$']
where len(year) = 15

--Where lenght(Year) = 17
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 17
order by YEAR

Select substring(year, 6,4)
from ['Movies Raw_Data$']
where year = '(I) (2012â€“2015)'
	or year = '(I) (2013â€“2014)'
	or year = '(I) (2013â€“2016)'
	or year = '(I) (2019â€“2020)'
order by YEAR

Update ['Movies Raw_Data$']
set Year = substring(year, 6,4)
from ['Movies Raw_Data$']
where year = '(I) (2012â€“2015)'
	or year = '(I) (2013â€“2014)'
	or year = '(I) (2013â€“2016)'
	or year = '(I) (2019â€“2020)'

Select substring(year, 2,4)
from ['Movies Raw_Data$']
where len(year) = 17
order by YEAR

Update ['Movies Raw_Data$']
set Year = substring(year, 2,4)
from ['Movies Raw_Data$']
where len(year) = 17

--Where lenght(Year) = 18
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 18
order by YEAR

Select Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 18
order by YEAR

Update ['Movies Raw_Data$']
set Year = Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 18

--Where lenght(Year) = 20
Select distinct(year)
from ['Movies Raw_Data$']
where Len(year) = 20
order by YEAR

Select Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 20
order by YEAR

Update ['Movies Raw_Data$']
set Year = Substring(year,7,4)
from ['Movies Raw_Data$']
where Len(year) = 20

-- Checking the year column

Select YEAR, COUNT(len(year)) as count_len
from ['Movies Raw_Data$']
where LEN(year) <> 4
Group by YEAR
order by YEAR

select distinct(LEN(year)) as length
from ['Movies Raw_Data$']
order by length

-- STEP # 2 /*EXTRACTING THE LEAD GENRE FROM GENRE*/ 

Select * from ['Movies Raw_Data$']

-- Finding the number of commas or substrings

select 
	distinct(len(GENRE) - len(replace(GENRE, ',', ''))) as Comma_number
From ['Movies Raw_Data$']
order by Comma_number

-- Where GENRE is null
Select GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) is null

Alter Table ['Movies Raw_Data$']
Add Lead_Genre nvarchar(255)

Update ['Movies Raw_Data$']
Set Lead_Genre = GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) is null

-- Where is there is no comma
Select GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 0

Update ['Movies Raw_Data$']
Set Lead_Genre = GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 0

--Where there is one comma
Select GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 1

Select GENRE,
PARSENAME(Replace(GENRE, ',','.'),2) as Lead_Genre,
PARSENAME(Replace(GENRE, ',','.'),1) as Genre_2
From ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 1

Update ['Movies Raw_Data$']
Set Lead_Genre = 
	PARSENAME(Replace(GENRE, ',','.'),2)
	From ['Movies Raw_Data$']
	where len(GENRE) - len(replace(GENRE, ',', '')) = 1

--Where there are two commas
Select GENRE
from ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 2

Select GENRE,
PARSENAME(Replace(GENRE, ',','.'),3) as Lead_Genre,
PARSENAME(Replace(GENRE, ',','.'),2) as Genre_2,
PARSENAME(Replace(GENRE, ',','.'),1) as Genre_3
From ['Movies Raw_Data$']
where len(GENRE) - len(replace(GENRE, ',', '')) = 2

Update ['Movies Raw_Data$']
Set Lead_Genre = 
	PARSENAME(Replace(GENRE, ',','.'),3)
	From ['Movies Raw_Data$']
	where len(GENRE) - len(replace(GENRE, ',', '')) = 2

-- For checking the Lead_Genre
select 
	distinct(len(Lead_Genre) - len(replace(Lead_Genre, ',', ''))) as Comma_number
From ['Movies Raw_Data$']
order by Comma_number

Select *
From ['Movies Raw_Data$']
-----------------------------------------------------------------------------------------------------------

-- STEP # 3 /*SEPARATING THE INFORMATION ON THE DIRECTORS AND STARS FROM THE STARS COLUMN*/ 

Select Stars from ['Movies Raw_Data$']   

select Stars,
	Parsename(Replace(Substring(Stars, -1, CHARINDEX('|', STARS,1 )), ':', '.'), 1)	as Director,
	Substring(Stars, CHARINDEX('|', STARS,1 ) +1, LEN(Stars)) as Stars
From ['Movies Raw_Data$']

Alter table ['Movies Raw_Data$']
Add Directors nvarchar(255)

Update ['Movies Raw_Data$']
Set Directors = Parsename(Replace(Substring(Stars, -1, CHARINDEX('|', STARS,1 )), ':', '.'), 1)
From ['Movies Raw_Data$']

Alter table ['Movies Raw_Data$']
Add Stars_1 Varchar(255)

Update ['Movies Raw_Data$']
Set Stars_1 = Substring(Stars, CHARINDEX('|', STARS,1 ) +1, LEN(Stars))
From ['Movies Raw_Data$']

-- STEP # 4 /*FOR EXTRACTING THE INFORMATION ON THE LEAD DIRECTOR*/

-- Checking the number of commas (substrings) in the Director column (0 - 6)

select 
	distinct(len(DirectorS) - len(replace(Directors, ',', ''))) as Comma_number
From ['Movies Raw_Data$']
order by Comma_number

Select Directors
from ['Movies Raw_Data$']
where (len(Directors) - len(replace(Directors, ',', ''))) is null

Select Directors
from ['Movies Raw_Data$']
where (len(Directors) - len(replace(Directors, ',', ''))) = 0

select Directors,
	Substring(LTRIM(Directors), 0, CHARINDEX(',', LTRIM(Directors), 1 ))	as Lead_Director,
	Substring(LTRIM(Directors), CHARINDEX(',', LTRIM(Directors),1 ) +1, LEN(LTRIM(Directors))) as Secodary_Directors
From ['Movies Raw_Data$']
where Directors is not null and (len(Directors) - len(replace(Directors, ',', ''))) <> 0

Alter Table ['Movies Raw_Data$']
Add Lead_Director nvarchar(255)

Update ['Movies Raw_Data$']
Set Lead_Director = Directors
from ['Movies Raw_Data$']
where (len(Directors) - len(replace(Directors, ',', ''))) is null

Update ['Movies Raw_Data$']
Set Lead_Director = Directors
from ['Movies Raw_Data$']
where (len(Directors) - len(replace(Directors, ',', ''))) = 0

Update ['Movies Raw_Data$']
Set Lead_Director = 	Substring(LTRIM(Directors), 0, CHARINDEX(',', LTRIM(Directors), 1 ))
From ['Movies Raw_Data$']
where Directors is not null and (len(Directors) - len(replace(Directors, ',', ''))) <> 0

-- For checking the Lead_Director Column
Select Directors, lead_director
from ['Movies Raw_Data$']

------------------------------------------------------------------------------------------------------------------------
-- STEP # 5 /*FOR EXTRACTING THE INFORMATION ON THE LEAD STAR*/

select Directors, Stars_1
from ['Movies Raw_Data$']

select Stars_1,
	Substring(Stars_1, -1, CHARINDEX(':', STARS_1,1 )),
	Substring(Stars_1, CHARINDEX(':', STARS_1,1 ) +1, LEN(Stars_1)) as Stars_2
From ['Movies Raw_Data$']

Alter table ['Movies Raw_Data$']
Add Stars_2 nvarchar(255)

Update ['Movies Raw_Data$']
Set Stars_2 = Substring(Stars_1, CHARINDEX(':', STARS_1,1 ) +1, LEN(Stars_1))
From ['Movies Raw_Data$']

-- Checking and comparing the new column

Select Director, STARS, Stars_1, stars_2
from ['Movies Raw_Data$']

select 
	distinct(len(Stars_2) - len(replace(len(Stars_2), ',', ''))) as Comma_number
From ['Movies Raw_Data$']
order by Comma_number


Select Stars_2
from ['Movies Raw_Data$']
where (len(lTrim(Stars_2)) - len(replace(lTrim(Stars_2), ',', ''))) = 0

select Stars_2,
	Substring(LTrim(Stars_2), 0, CHARINDEX(',', LTrim(Stars_2),1)) as Lead_star,
	Substring(LTrim(Stars_2), CHARINDEX(',', LTrim(Stars_2),1) +1, LEN(LTrim(Stars_2))) as Remaining_star
From ['Movies Raw_Data$']
where (len(lTrim(Stars_2)) - len(replace(lTrim(Stars_2), ',', ''))) <> 0

Alter table ['Movies Raw_Data$']
Add Lead_star nvarchar(255)

Update ['Movies Raw_Data$']
Set Lead_star = Stars_2
from ['Movies Raw_Data$']
where (len(lTrim(Stars_2)) - len(replace(lTrim(Stars_2), ',', ''))) = 0

Update ['Movies Raw_Data$']
Set Lead_star = Substring(LTrim(Stars_2), 0, CHARINDEX(',', LTrim(Stars_2),1))
From ['Movies Raw_Data$']
where (len(lTrim(Stars_2)) - len(replace(lTrim(Stars_2), ',', ''))) <> 0

--Checking and comparing the new column
select MOVIES, Stars_2, Lead_star
from ['Movies Raw_Data$']
-----------------------------------------------------------------------------------------------------------------------------

-- STEP # 6 /*CLEANING THE GROSS COLUMN*/

Select Gross
from ['Movies Raw_Data$']

Select Distinct(len(Gross))
from ['Movies Raw_Data$']
order by LEN(Gross)

Select 
	SUBSTRING(Gross, 1,5)
from ['Movies Raw_Data$']
where LEN(Gross) = 6

Update ['Movies Raw_Data$']
Set Gross = SUBSTRING(Gross, 1,5)
	from ['Movies Raw_Data$']
	where LEN(Gross) = 6

Select 
	SUBSTRING(Gross, 1,6)
from ['Movies Raw_Data$']
where LEN(Gross) = 7

Update ['Movies Raw_Data$']
Set Gross = SUBSTRING(Gross, 1,6)
	from ['Movies Raw_Data$']
	where LEN(Gross) = 7

Select 
	SUBSTRING(Gross, 1,7)
from ['Movies Raw_Data$']
where LEN(Gross) = 8

Alter Table ['Movies Raw_Data$']
Add Gross_Clean nvarchar(255)

Update ['Movies Raw_Data$']
Set Gross_Clean = SUBSTRING(Gross, 1,5)
from ['Movies Raw_Data$']
where LEN(Gross) = 6

Update ['Movies Raw_Data$']
Set Gross_Clean = SUBSTRING(Gross, 1,6)
from ['Movies Raw_Data$']
where LEN(Gross) = 7

Update ['Movies Raw_Data$']
Set Gross_Clean = SUBSTRING(Gross, 1,7)
from ['Movies Raw_Data$']
where LEN(Gross) = 8

Select Gross_Clean
from ['Movies Raw_Data$']

-----------------------------------------------------------------------------------------------------------------------------
-- STEP # 7 /*REMOVING DUPLICATES*/


With RownumCTE as (
Select *,
	ROW_NUMBER() Over(
	Partition By Movies,
				 Year,
				 Lead_Director
				 Order by Year
				 ) as Row_num
from ['Movies Raw_Data$']
)
Select * from RownumCTE
where Row_num > 1

-- Deleting Dulplicates
With RownumCTE as (
Select *,
	ROW_NUMBER() Over(
	Partition By Movies,
				 Year,
				 Lead_Director
				 Order by Year
				 ) as Row_num
from ['Movies Raw_Data$']
)
Delete
from RownumCTE
where Row_num > 1

-----------------------------------------------------------------------------------------------------------------------------
-- STEP # 7 /*DELETING UNUSED COLUMNS*/

Select * 
from ['Movies Raw_Data$']

Alter Table ['Movies Raw_Data$']
Drop Column Genre, One_line, Stars, Gross, Directors, Stars_1, Stars_2 

-----------------------------------------------------------------------------------------------------------------------------
-- STEP # 8 /*DEVELOPING A METRIC FOR POPULARITY*/

-- Calculating Percent Rank

Select 
	MOVIES,
	PERCENT_RANK() over (
				   order by Votes
				   ) as Percentile_Rank
from ['Movies Raw_Data$']
Order by Percentile_Rank Desc

Alter table ['Movies Raw_Data$']
Add Per_Rank nvarchar (255)

With CTE as(
Select 
	MOVIES,
	PERCENT_RANK() over (
				   order by Votes
				   ) as Percentile_Rank
from ['Movies Raw_Data$'])
Update ['Movies Raw_Data$']
Set ['Movies Raw_Data$'].Per_Rank = Round(CTE.Percentile_Rank,2)
from CTE
where CTE.Movies = ['Movies Raw_Data$'].MOVIES


Select VOTES, PER_RANK 
from ['Movies Raw_Data$']
--where PER_Rank is null
Order by Per_Rank Desc


-- For defining category. (If Rank_Percentile > 90 then Blockbuster, If Rank_Percentile > 60  then Super Hit,
-- if Rank_Percentile > 30 then Hit, if Rank Percentile <= 30 the Flop


Select Per_Rank, Movies,
Case when Convert(Float, Per_Rank) > 0.90 then 'Block Buster' 
	when Convert(Float, Per_Rank) <=  0.90 and Convert(Float, Per_Rank) > 0.60 then 'Super Hit'
	When Convert(Float, Per_Rank) <= .60 and Convert(Float, Per_Rank) > 0.3 then 'Hit'
	When Convert(Float, Per_Rank) <= 0.3 then 'Flop'
	else Per_Rank
	End
from ['Movies Raw_Data$']
Where VOTES is not null
Order by Per_Rank desc-

Alter Table ['Movies Raw_Data$']
Add Popularity nvarchar(255)

Update ['Movies Raw_Data$']
Set Popularity = Case when Convert(Float, Per_Rank) > 0.90 then 'Block Buster' 
	when Convert(Float, Per_Rank) <=  0.90 and Convert(Float, Per_Rank) > 0.60 then 'Super Hit'
	When Convert(Float, Per_Rank) <= .60 and Convert(Float, Per_Rank) > 0.3 then 'Hit'
	When Convert(Float, Per_Rank) <= 0.3 then 'Flop'
	else Per_Rank
	End
from ['Movies Raw_Data$']
Where VOTES is not null


Select *
from ['Movies Raw_Data$']
where Popularity is null


Delete from ['Movies Raw_Data$']
where Popularity is null


Select *
From ['Movies Raw_Data$']