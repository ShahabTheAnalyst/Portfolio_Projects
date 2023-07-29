/* Covid 19 Data Exploration*/

-- Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Veiws, Converting Data Types

Use Covid_19

Select *
From Covid19_deaths

-- 1. Looking at the Location and Continents
Select *
From Covid19_deaths
Where continent is null
order by location, date

Select Distinct(iso_code), location, continent
From Covid19_deaths
Where continent is null

Select Distinct(iso_code), location, continent
From Covid19_deaths
Where continent is not null

-- 2. Looking at covid 19 cases, and deaths
select Location, date, total_cases, new_cases, total_deaths, new_deaths, population
From Covid19_deaths
Order by 1, 2

-- 3. Total Death vs Total case 
-- Shows the likelyhood of dying if infected by Covid 19 (only Countries)

Select Location, date, total_cases, total_deaths, (cast(total_deaths as int)/total_cases)*100 as Death_Percentage_Country
from Covid19_deaths
Where continent is not null
Order By 1, 2

-- 4. Total Case vs Population 
-- Shows the percentage of population infected (only countries)
Select Location, date, total_cases, population, (CONVERT(int, total_cases)/population)*100 as Percent_pop_infected 
From Covid19_deaths
Where continent is not null
Order By 1, 2

-- 5. Countries With Higest Infection Rate
	-- It can be done in two ways
	
	--A. By using new_cases

Select Location, Population, Sum(cast(new_cases as int)) as Total_Cases, 
		(sum(Convert(int, new_cases)/population)*100) as Percent_popinfected
from Covid19_deaths
Group By Location, population
order by Percent_popinfected Desc

	.-- B. By using total_cases
	   
Select Location, Population, Max(Cast(total_cases as int)) as Max_cases, 
		Max(Convert(int, total_cases))/population*100 as Percent_popinfected
from Covid19_deaths
Group By Location, population
order by Percent_popinfected Desc

-- 6. Countries with the highest death count (only countries)

Select Location, max(convert(int, total_deaths)) as Total_death_count
From Covid19_deaths
Where continent is not null
Group by Location
Order By Total_death_count Desc

-- CONTINENTS

-- 7. Continents World and Countries (by Income)  With Higest Infection Rate
	
Select Location, Population, Sum(cast(new_cases as int)) As Total_case, 
	(sum(Convert(int, new_cases)/population)*100) as Percent_popinfected
from Covid19_deaths
Where continent is null
Group By Location, population
order by Percent_popinfected Desc

-- 8. Continents World and Countries (by Income) with the highest death count

Select Location, max(convert(int, total_deaths)) as Total_death_count
From Covid19_deaths
Where continent is null
Group by Location
Order By Total_death_count Desc

-- 9. Percent of Total Population Vaccinated
select death.continent, death.location, death.date, vacci.new_vaccinations, sum(convert(bigint,vacci.new_vaccinations))
Over (Partition by 
		death.location
		order by death.location, death.date) as Rolling_people_vaccinated
from Covid19_deaths As death
join Covid19_vacci As vacci
on death.location = vacci.location and death.date =vacci.date
where death.continent is not null

-- Using CTE

With CTE (continent, location, date, population, new_vaccinations, Rolling_people_vaccinated) as
(select death.continent, death.location, death.date, death.population, vacci.new_vaccinations, 
	sum(convert(bigint,vacci.new_vaccinations))
Over (Partition by 
	death.location
	order by death.location, death.date) as Rolling_people_vaccinated
from Covid19_deaths As death
join Covid19_vacci As vacci
on death.location = vacci.location and death.date =vacci.date
where death.continent is not null)
select *, (Rolling_people_vaccinated/population)*100 as Rolling_people_vaccinated
from CTE

-- Using Temp Table

Drop Table if exists #Percent_pop_vaccinated
Create Table #Percent_pop_vaccinated (
continent nvarchar(250),
location nvarchar(250),
date date,
population numeric, 
new_vaccinations numeric, 
Rolling_people_vaccinated numeric)

Insert into #Percent_pop_vaccinated 
select death.continent, death.location, death.date, death.population, vacci.new_vaccinations, 
	sum(convert(bigint,vacci.new_vaccinations))
Over (Partition by 
	death.location
	order by death.location, death.date) as Rolling_people_vaccinated
from Covid19_deaths As death
join Covid19_vacci As vacci
on death.location = vacci.location and death.date =vacci.date

Select *, (Rolling_people_vaccinated/population)*100
from #Percent_pop_vaccinated

-- 10. Creating View to store data for Visualizations

-- A. Countries with the highest infection rate
Create view Percent_popinfected as
Select Location, Population, Sum(cast(new_cases as int)) as Total_Cases, 
		(sum(Convert(int, new_cases)/population)*100) as Percent_popinfected
from Covid19_deaths
Group By Location, population
--order by Percent_popinfected Desc
