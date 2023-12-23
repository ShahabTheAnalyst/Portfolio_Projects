/* Covid 19 Data Exploration*/

-- Skills used: Joins, Aggregate Functions, Converting Data Types, Windows Functions, Temp Tables, CTE's, Creating Veiws 

Use Covid_19

-- 1. Checking out the Covid_deaths table

Select
	*
From 
	Covid_deaths

/* It seems that the tables contains  information on population, covid case, deaths, reproduction rate, 
and hospitalization by continent, country and date.*/


--  Checking out the number of columns and rows in the covid_deaths table
SELECT 
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'covid_deaths') AS NumberOfColumns,
    (SELECT SUM(row_count) FROM sys.dm_db_partition_stats WHERE object_id = OBJECT_ID('covid_deaths')) AS NumberOfRows;

	/* The output shows that there are 26 columns and 327369 rows in the table.*/


-- 2. Checking out the Location column

Select 
	distinct(location)
from
	covid_deaths
order 
	by location
	
/* The output reveals that the locations column has information on countries as well as continents, high income,
low income, or middle income. */

-- For isolating the information in the location other than country names

Select 
	distinct(location)
From
	Covid_deaths
Where 
	continent is null

/* The output confirms that beside the name of countries the location column contains information on continent,
Lower middle income, Low income, European Union,  Upper middle income,  High income */

-- For isolating information on Lower middle income, Low income, Upper middle income, and High income

Select
	distinct(location)
From 
	Covid_deaths
Where 
	continent is null and 
	location <> 'Asia' and
	location <> 'Africa' and
	location <> 'Europe' and
	location <> 'Oceania' and
	location <> 'North America' and
	location <> 'South America' and
	location <> 'World' and
	location <> 'European Union'

-- The same can be done by the following query also
Select
	distinct(location)
From 
	Covid_deaths
Where 
	continent is null and 
	location = 'High income' or
	location = 'Upper middle income' or
	location = 'Lower middle income' or
	location = 'Low income'

/* The output shows that there are 4 categories of countries by income*/

-- 3. Checking out the continent column

Select 
	distinct(continent)
from 
	covid_deaths
Where continent is not null

/* The output shows that the continent column has information on continents only.*/

/* NOTE: There are group of countries like European Union, High income Low income, Lower middle income, Upper middle income, 
World. One thing that we have to take into condieration is that if a country lets say France will have separate information, 
also the information on France will be included in World, High income, and  European Union etc. Therefore should be careful in 
our analysis to avoid any bias or error while utilizing the information contained in the Location column.*/


-- 4. Looking at location, date, covid cases, deaths, and population and ordering it by Location and date 
--	  in ascending order

select 
	Location, 
	date, 
	total_cases, 
	new_cases, 
	total_deaths, 
	new_deaths, 
	population
From 
	Covid_deaths
Order by 
	1, 2


-- 5. Total Deaths vs Total cases (likelyhood of dying if infected by Covid 19)

	-- A. Countries

SELECT
    Location,
    max(convert(int,total_cases)) as total_cases,
    max(convert(int,total_deaths)) as total_deaths,
    max(CAST(total_deaths AS float)) * 100 / max(CAST(total_cases AS float)) AS Death_Percentage_Country
FROM
    Covid_deaths
WHERE
    continent IS NOT NULL
Group by location
ORDER BY
    4 desc

/* The output shows that probability of dying if infected with covid 19 is the highest (18 percent).*/

	--B. Continent

SELECT
    continent,
    max(convert(int,total_cases)) as total_cases,
    max(convert(int,total_deaths)) as total_deaths,
    max(CAST(total_deaths AS float)) * 100 / max(CAST(total_cases AS float)) AS Death_Percentage_Country
FROM
    Covid_deaths
WHERE
    continent IS NOT NULL
Group by continent
ORDER BY
    4 desc

/* The output shows that if infected with covid 19 the probability of dying is higest in case of Africa (2.5 percent)
while Oceania has the lowest (0.19 percent).*/

	-- C. Countries by income

SELECT
    location,
    max(convert(int,total_cases)) as total_cases,
    max(convert(int,total_deaths)) as total_deaths,
    max(CAST(total_deaths AS float)) * 100 / max(CAST(total_cases AS float)) AS Death_Percentage_Country
FROM
    Covid_deaths
WHERE
    continent is null and 
	location = 'High income' or
	location = 'Upper middle income' or
	location = 'Lower middle income' or
	location = 'Low income' 
Group by location
ORDER BY
    4 desc

/* The output shows that if infected with covid 19 then the probability of dying is the highest in low income 
countries (2.07 percent) while it is the lowest in case of high income countries.*/

--6. Checking the likelyhood of contract the infection by month (country).

SELECT
    MONTH(date) AS Month,
    AVG(CAST(new_cases AS FLOAT) / convert(float,total_cases)) * 100 AS infection_rate_monthwise
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL
GROUP 
	BY MONTH(date)
order by 
	2 desc

/* The output shows that there is surge infection rate is higher in the first 4 months of the year,
especially the March and April*/


--7. Checking out the death percentage by month.

SELECT
    MONTH(date) AS Month,
    AVG(CAST(total_deaths AS FLOAT) / total_cases) * 100 AS Death_Percentage_monthwise
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* The output shows that the likelyhood of dying from covid is far more high in March, April, May. This might be due to
the fact that the infection rate is higher in the first five months of the year. However further investigation is 
needed.*/

--8. Investigating by each year (2020, 2021, 2022, 2023)

-- Getting the distinct years for checking the death percentage by year.

select 
	distinct(year(date))
from 
	covid_deaths
order by 
	year(date)

	-- A. INVESTIGATING MONTHWISE DEATH PERCENTAGE BY YEAR
	
	-- Death percentage per month for the year 2020

SELECT
    MONTH(date) AS Month,
    AVG(CAST(total_deaths AS FLOAT) / total_cases) * 100 AS Death_Percentage_2020
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2020
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* The output shows first five months of the year 2020 were horrific with the death percentage reaching as high
as 393.6 percent.*/

	--  Death percentage per month for the year 2021

SELECT
    MONTH(date) AS Month,
    AVG(CAST(total_deaths AS FLOAT) / total_cases) * 100 AS Death_Percentage_2021
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2021
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* Death percentage is marginally higher in the first 4 months of the year 2021*/

	--  Death percentage per month for the year 2022

SELECT
    MONTH(date) AS Month,
    AVG(CAST(total_deaths AS FLOAT) / total_cases) * 100 AS Death_Percentage_2022
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2022
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* Death percentage is higher at the begining of the year 2022 and then starts declining*/

	--  Death percentage per month for the year 2023

SELECT
    MONTH(date) AS Month,
    AVG(CAST(total_deaths AS FLOAT) / total_cases) * 100 AS Death_Percentage_2023
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2023
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* The death percentage is almost uniform across the first 7 months of 2023*/ 


	--	B. INVESTIGATING MONTHWISE INFECTION RATE BY YEAR

-- Infection rate per month for the year 2020
SELECT
    MONTH(date) AS Month,
    AVG(CAST(new_cases AS FLOAT) / total_cases) * 100 AS infection_rate_2020
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2020
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* Infection rate is high in the first five months, especially in the first 3 months.*/

	-- Infection rate per month for the year 2021
SELECT
    MONTH(date) AS Month,
    AVG(CAST(new_cases AS FLOAT) / total_cases) * 100 AS infection_rate_2021
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2021
GROUP BY 
	MONTH(date)
order by 
	2 desc


/* Infection rate is higher in the start of the year 2021 and then starts declining. 
The infection rate is lower than in year 2020.*/

	-- Infection rate per month for the year 2022
SELECT
    MONTH(date) AS Month,
    AVG(CAST(new_cases AS FLOAT) / total_cases) * 100 AS infection_rate_2022
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2022
GROUP BY 
	MONTH(date)
order by 
	2 desc


/* The infection rate is higher at the start of the year and then declines.*/ 

-- Infection rate per month for the year 2023
SELECT
    MONTH(date) AS Month,
    AVG(CAST(new_cases AS FLOAT) / total_cases) * 100 AS infection_rate_2023
FROM 
	Covid_deaths
WHERE 
	continent IS NOT NULL and 
	year(date) = 2023
GROUP BY 
	MONTH(date)
order by 
	2 desc

/* The infection rate is again higher higher at the start of the year and then declines through out the year.*/ 

/* By analyzing the output of the above queries shows that over period of time the infection and death rates are declining.*/


-- 9. Total Case vs Population 

-- For checking out percent of population infected by country

Select 
	location, 
	max(CONVERT(int, total_cases)/population)*100 as Percent_pop_infected 
From 
	Covid_deaths
Where 
	continent is not null
group by 
	location
Order By 
	2 desc

/* The out put shows that Cyprus has the highest percentage of population infected (73.75%).
While scrolling through the output it came to light that in case of Northern Cyprus, Turkmenistan Northern Ireland,
Taiwan, North Korea, Macao, Scotland, England, Western Sahara, Wales, Hong Kong, the percentage values are null.
We need to investigate it.*/

select 
	location,
	total_cases, 
	new_cases
from 
	covid_deaths
where 
	location = 'Northern Cyprus' 
	and (total_cases is not null or	new_cases is not null)

/* The output shows that there is no data on new infection and total infections in case of Northern Cyprus*/ 

select 
	population
from 
	covid_deaths
where 
	location = 'Northern Cyprus' 
		and population is null

/* There is no null in the population column in case of Northern Cyprus*/

/* The other countries should also be investigated in to check the status of total infections, new infections and
population.*/


-- Percent of population infected by continent 

Select 
	continent, 
	max(CONVERT(int, total_cases)/population)*100 as Percent_pop_infected 
From 
	Covid_deaths
Where 
	continent is not null
group by 
	continent
Order By 
	2 desc

/* The output shows that the percentage of population effected infected is the highest in case of Europe, while it is the 
lowest in case of Oceania*/ 

-- Percent of population infected by classification of countries by income

Select 
	location, 
	max(CONVERT(int, total_cases)/population)*100 as Percent_pop_infected 
From 
	Covid_deaths
Where 
	continent is null and 
	location = 'High income' or
	location = 'Upper middle income' or
	location = 'Lower middle income' or
	location = 'Low income'
group by 
	location
Order By 
	2 desc

/* The output shows that the percentage of population effected infected is the highest in case of High income countries,
, while it is the lowest in case of low income countries.*/


-- 10. Death count 

-- By Countries
Select 
	Location, 
	max(convert(int, total_deaths)) as Total_death_count
From 
	Covid_deaths
Where 
	continent is not null
Group by 
	Location
Order By 
	Total_death_count Desc

/* The output shows that United States has the highest death count while Tuvalu has the lowest.*/ 

-- Continents
Select 
	location, 
	max(convert(int, total_deaths)) as Total_death_count
From 
	Covid_deaths
Where 
	continent is null 
	and (
	location = 'Africa' 
	or location = 'Asia' 
	or location = 'Europe' 
	or location = 'North America' 
	or location = 'Oceania' 
	or location = 'South America'
	)
Group by 
	location
Order By 
	2 desc


/* Europe has  the highest death count while Oceania has the lowest.*/

-- Income Group

Select 
	location, 
	max(CONVERT(int, total_deaths)) as Total_death_count 
From 
	Covid_deaths
Where 
	continent is null and 
	location = 'High income' or
	location = 'Upper middle income' or
	location = 'Lower middle income' or
	location = 'Low income'
group by 
	location
Order By 
	2 desc

/* High income countries has the highest death count while Low income countries has the lowest.*/

-- 11. Fertility rate

select 
	*
from 
	covid_deaths

-- By countries 
select 
	location, 
	avg(convert(float,reproduction_rate)) as avg_reproduction_rate
from 
	covid_deaths
where 
	continent is not null
group by 
	location
order by 
	2 desc

/* Spain had the highest reproduction rate, while Nauru has the lowest. 
There are 49 countries for which we have null values for reproduction. Look into it*/

-- By continent

select 
	continent, 
	avg(convert(float,reproduction_rate)) as avg_reproduction_rate
from 
	covid_deaths
where 
	continent is not null
group by 
	continent
order by 
	2 desc

/* Europe has the highest reproduction rate while Oceania has the lowest*/

-- Income Group

Select 
	location, 
	avg(convert(float, reproduction_rate)) as avg_reproduction_rate
from 
	covid_deaths
where 
	continent is null and  
	location = 'Lower middle income' or
	location = 'Low income' or
	location = 'Upper middle income' or
	location = 'High income'
group by location

/* It seems that there is no data on reproduction rate in case of classification of countries by income*/ 

select 
	location, 
	reproduction_rate
from 
	covid_deaths
where 
	reproduction_rate is not null and 
		(
		location = 'Lower middle income' or
		location = 'Low income' or
		location = 'Upper middle income' or
		location = 'High income'
		)

--12. Checking the Covid_vacci table

Select 
	*
From
	covid_vacci

-- checking number of rows and columns

SELECT 
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'covid_vacci') AS NumberOfColumns,
    (SELECT SUM(row_count) FROM sys.dm_db_partition_stats WHERE object_id = OBJECT_ID('covid_vacci')) AS NumberOfRows;


-- 13. Percent of Total Population Vaccinated

-- For investigating which column contains information on vaccination that we can use for our analysis. 

With CTE (location, population, fully_vaccinated, people_vaccinated) as (
	select 
		death.location, 
		death.population,
		max(convert(bigint, vacci.people_fully_vaccinated)) as fully_vaccinated,
		sum(convert(bigint,vacci.people_vaccinated)) as people_vaccinated
	from 
		covid_vacci as vacci
join
	covid_deaths as death
on
	vacci.location = death.location and vacci.date = death.date
group by 
	death.location,
	population
)
select 
	location, 
	((fully_vaccinated/population)*100) as percentage_fully_vaccinated,
	((people_vaccinated/population)*100) as percentage_people_vaccinated
	from CTE
	order by 2 desc

/* The output shows that the column people_fully_vaccinated contains information on the number of people fully vaccinated.
Thus we will use it.*/

-- 14. Checking average rolling people vaccinated by year
	
	-- Country 
	--Using CTE

With CTE (continent, location, date, population, people_fully_vaccinated, Rolling_people_vaccinated) as
(
select 
	death.continent, 
	death.location, 
	death.date, 
	death.population, 
	vacci.people_fully_vaccinated, 
	max(convert(bigint,vacci.people_fully_vaccinated)) Over (Partition by death.location order by death.location, death.date) as Rolling_people_vaccinated
	from 
		Covid_deaths As death
	join 
		Covid_vacci As vacci
	on 
		death.location = vacci.location and death.date =vacci.date
	where 
		death.continent is not null
		)
select 
	location, 
	year(date) as year, 
	avg((Rolling_people_vaccinated/population)*100) as Rolling_percent_people_vaccinated
from 
	CTE
where 
	continent is not null
group by 
	location, year(date)
order by
	location, year(date)

-- Continent wise average rolling people vaccinated by year
	-- Using Temp Table

Drop Table if exists #Percent_pop_vaccinated
Create Table #Percent_pop_vaccinated (
	continent nvarchar(250),
	location nvarchar(250),
	date date,
	population numeric, 
	fully_vaccinated numeric, 
	Rolling_people_vaccinated numeric)

Insert into #Percent_pop_vaccinated 
select 
	death.continent, 
	death.location, 
	death.date, 
	death.population, 
	vacci.people_fully_vaccinated, 
	max(convert(bigint,vacci.people_fully_vaccinated))
		Over (Partition by 
		death.location
		order by death.location, death.date) as Rolling_people_vaccinated
from 
	Covid_deaths As death
join 
	Covid_vacci As vacci
on 
	death.location = vacci.location and death.date =vacci.date

Select 
	continent, 
	year(date), 
	avg((Rolling_people_vaccinated/population)*100)
from 
	#Percent_pop_vaccinated
where 
	continent is not null
group by 
	year(date), 
	continent
order by 
	1, 
	2

/* The output shows that the vaccinated percentage of population on each continent has increased over the years.*/

-- For by income group
Drop Table if exists 
	#Percent_pop_vaccinated_income

Create Table #Percent_pop_vaccinated_income (
	continent nvarchar(250),
	location nvarchar(250),
	date date,
	population numeric, 
	fully_vaccinated numeric, 
	Rolling_people_vaccinated numeric
	)

Insert into #Percent_pop_vaccinated_income 
select 
	death.continent, 
	death.location, 
	death.date, 
	death.population, 
	vacci.people_fully_vaccinated, 
	max(convert(bigint,vacci.people_fully_vaccinated))
Over (
	Partition by 
		death.location
	order by 
		death.location, 
		death.date
			) as Rolling_people_vaccinated
from 
	Covid_deaths As death
join 
	Covid_vacci As vacci
on 
	death.location = vacci.location and
	death.date =vacci.date

Select 
	location, 
	year(date) as Year, 
	avg((Rolling_people_vaccinated/population)*100)
from 
	#Percent_pop_vaccinated_income
where 
	location = 'World' or 
	location = 'High income' or
	location = 'Upper middle income' or
	location = 'Lower middle income' or
	location = 'Low income'
group by 
	year(date), 
	location
order by 
	1, 
	2

-- 15. Calculating the percentile rank based on the ratio of fully vaccinated people to the population for each location

WITH VaccinationData AS (
    SELECT
        vacci.location,
		MAX(convert(bigint,vacci.people_fully_vaccinated)) as max_fully_vaccinated,
        death.population
    FROM covid_vacci as vacci
    JOIN covid_deaths as death
    ON vacci.location = death.location AND vacci.date = death.date
    where death.continent is not null
	GROUP BY vacci.location, death.population
)
SELECT
    location,
    PERCENT_RANK() OVER (ORDER BY (max_fully_vaccinated / population) * 100) as Percentile_Rank
FROM VaccinationData
ORDER BY Percentile_Rank DESC


-- 16. Creating View to store data for Visualizations

--Percentile Rank 
Create view percentile_rank_location as
WITH VaccinationData AS (
    SELECT
        vacci.location,
		MAX(convert(bigint,vacci.people_fully_vaccinated)) as max_fully_vaccinated,
        death.population
    FROM covid_vacci as vacci
    JOIN covid_deaths as death
    ON vacci.location = death.location AND vacci.date = death.date
    where death.continent is not null
	GROUP BY vacci.location, death.population
)

SELECT
    location,
    PERCENT_RANK() OVER (ORDER BY (max_fully_vaccinated / population) * 100) as Percentile_Rank
FROM VaccinationData


select * from percentile_rank_location
order by Percentile_Rank desc