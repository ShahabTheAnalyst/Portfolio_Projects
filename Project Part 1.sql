use Portfolio_Project

-- Covid_death Data Type Conversion

Alter Table covid_deaths
Alter Column iso_code varchar(10)

Alter Table covid_deaths
Alter Column continent varchar(50)

Alter Table covid_deaths
Alter Column location varchar(50)

Alter Table covid_deaths
Alter Column date date

Alter Table covid_deaths
Alter Column population bigint

Alter Table covid_deaths
Alter Column total_cases int

Alter Table covid_deaths
Alter Column new_cases int

Alter Table covid_deaths
Alter Column new_cases_smoothed float

Alter Table covid_deaths
Alter Column total_deaths int

Alter Table covid_deaths
Alter Column new_deaths int

Alter Table covid_deaths
Alter Column new_deaths_smoothed float

Alter Table covid_deaths
Alter Column total_cases_per_million float

Alter Table covid_deaths
Alter Column new_cases_per_million float

Alter Table covid_deaths
Alter Column new_cases_smoothed_per_million float

Alter Table covid_deaths
Alter Column total_deaths_per_million float

Alter Table covid_deaths
Alter Column new_deaths_per_million float

Alter Table covid_deaths
Alter Column new_deaths_smoothed_per_million float

Alter Table covid_deaths
Alter Column reproduction_rate float

Alter Table covid_deaths
Alter Column icu_patients int

Alter Table covid_deaths
Alter Column icu_patients_per_million float

Alter Table covid_deaths
Alter Column hosp_patients int

Alter Table covid_deaths
Alter Column hosp_patients_per_million float

Alter Table covid_deaths
Alter Column weekly_icu_admissions int

Alter Table covid_deaths
Alter Column weekly_icu_admissions_per_million float

Alter Table covid_deaths
Alter Column weekly_hosp_admissions int

Alter Table covid_deaths
Alter Column weekly_hosp_admissions_per_million float

-- Covid_vaccination data type conversion

Alter Table Covid_vaccinations
Alter Column iso_code varchar(50)	

Alter Table Covid_vaccinations
Alter Column continent varchar(50)	

Alter Table Covid_vaccinations
Alter Column location varchar(50)

Alter Table Covid_vaccinations
Alter Column date date

Alter Table Covid_vaccinations
Alter Column total_tests bigint

Alter Table Covid_vaccinations
Alter Column new_tests int

Alter Table Covid_vaccinations
Alter Column total_tests_per_thousand float

Alter Table Covid_vaccinations
Alter Column new_tests_per_thousand float

Alter Table Covid_vaccinations
Alter Column new_tests_smoothed float

Alter Table Covid_vaccinations
Alter Column new_tests_smoothed_per_thousand float

Alter Table Covid_vaccinations
Alter Column positive_rate float

Alter Table Covid_vaccinations
Alter Column tests_per_case float

Alter Table Covid_vaccinations
Alter Column tests_units varchar(50)

Alter Table Covid_vaccinations
Alter Column total_vaccinations bigint

Alter Table Covid_vaccinations
Alter Column people_vaccinated bigint

Alter Table Covid_vaccinations
Alter Column people_fully_vaccinated bigint

Alter Table Covid_vaccinations
Alter Column total_boosters bigint

Alter Table Covid_vaccinations
Alter Column new_vaccinations int

Alter Table Covid_vaccinations
Alter Column new_vaccinations_smoothed float

Alter Table Covid_vaccinations
Alter Column total_vaccinations_per_hundred float

Alter Table Covid_vaccinations
Alter Column people_vaccinated_per_hundred float

Alter Table Covid_vaccinations
Alter Column people_fully_vaccinated_per_hundred float

Alter Table Covid_vaccinations
Alter Column total_boosters_per_hundred float

Alter Table Covid_vaccinations
Alter Column new_vaccinations_smoothed_per_million float

Alter Table Covid_vaccinations
Alter Column new_people_vaccinated_smoothed float

Alter Table Covid_vaccinations
Alter Column new_people_vaccinated_smoothed_per_hundred float

Alter Table Covid_vaccinations
Alter Column stringency_index float

Alter Table Covid_vaccinations
Alter Column population_density float

Alter Table Covid_vaccinations
Alter Column median_age float

Alter Table Covid_vaccinations
Alter Column aged_65_older float

Alter Table Covid_vaccinations
Alter Column aged_70_older float

Alter Table Covid_vaccinations
Alter Column gdp_per_capita float

Alter Table Covid_vaccinations
Alter Column extreme_poverty float

Alter Table Covid_vaccinations
Alter Column cardiovasc_death_rate float

Alter Table Covid_vaccinations
Alter Column diabetes_prevalence float

Alter Table Covid_vaccinations
Alter Column female_smokers float

Alter Table Covid_vaccinations
Alter Column male_smokers float

Alter Table Covid_vaccinations
Alter Column handwashing_facilities float

Alter Table Covid_vaccinations
Alter Column hospital_beds_per_thousand float

Alter Table Covid_vaccinations
Alter Column life_expectancy float

Alter Table Covid_vaccinations
Alter Column human_development_index float

Alter Table Covid_vaccinations
Alter Column excess_mortality_cumulative_absolute float

Alter Table Covid_vaccinations
Alter Column excess_mortality_cumulative float

Alter Table Covid_vaccinations
Alter Column excess_mortality float

Alter Table Covid_vaccinations
Alter Column excess_mortality_cumulative_per_million float

Select *
from covid_deaths
where continent is not null
order by 3, 4

--Select *
--from Covid_vaccinations
--order by 3, 4

-- Select Data that we are going to be using.
Select location, date, total_cases, new_cases, total_deaths, population
from covid_deaths
where continent is not null
order by 1, 2

-- Looking at the total cases vs total deaths
-- Shows the likelyhood of dying if you contract covid in Canada

Select location, date, total_cases, total_deaths, (cast(total_deaths as float)/total_cases)*100 as Death_percentage
from covid_deaths
where continent is not null
order by 1, 2

Select location, date, total_cases, total_deaths, (cast(total_deaths as float)/total_cases)*100 as Death_percentage
from covid_deaths
where location = 'Canada' and continent is not null
order by 1, 2

-- Looking at the Total Case vs Population
-- Shows what percentage of population were effected by covid

Select location, date, population, total_cases, (cast(total_cases as float)/population)*100 as Case_percentage
from covid_deaths
where continent is not null
order by 1, 2

Select location, date, population, total_cases, (cast(total_cases as float)/population)*100 as Case_percentage
from covid_deaths
where location = 'Canada' and continent is not null
order by 1, 2

-- Looking at Countries with Highest Infection Rate compared to Population

Select location, population, max(total_cases) as Highest_infectioncount, 
((cast(max(total_cases) as float))/population)*100 as Percent_pop_infected
from covid_deaths
where continent is not null
group by location, population
order by Percent_pop_infected Desc

-- Showing Countries with the highest death count per population

Select location, max(total_deaths) as Highest_death, 
((cast(max(total_deaths) as float))/population)*100 as Percent_pop_dead
from covid_deaths
where continent is not null
group by location, population
order by Percent_pop_dead Desc

Select location, max(total_deaths) as Total_death_count
from covid_deaths
where continent is not null
group by location
order by Total_death_count Desc


-- Showing Continents with the highest death count per population
Select continent, max(total_deaths) as Total_death_count
from covid_deaths
where continent is not null
group by continent
order by Total_death_count Desc

		-- For Verfiying the number in the above query

			Select continent, location, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'North America'
			group by continent, location
			order by Total_death_count Desc

			Select continent, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'South America'
			group by continent, location
			order by Total_death_count Desc

			Select continent, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'Asia'
			group by continent, location
			order by Total_death_count Desc

			Select continent, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'Europe'
			group by continent, location
			order by Total_death_count Desc

			Select continent, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'Africa'
			group by continent, location
			order by Total_death_count Desc

			Select continent, max(total_deaths) as Total_death_count
			from covid_deaths
			where continent = 'Oceania'
			group by continent, location
			order by Total_death_count Desc

-- Global Numbers

Select sum(new_cases) as Total_case, sum(new_deaths) as Total_deaths, 
(sum(cast(new_deaths as float))/sum(new_cases)) *100 as Deathp_percentage
from covid_deaths
-- where location = 'Canada'
where continent is not null and new_cases <> 0
order by 1,2

Select date, sum(new_cases) as Total_case, sum(new_deaths) as Total_deaths, 
(sum(cast(new_deaths as float))/sum(new_cases)) *100 as Deathp_percentage
from covid_deaths
-- where location = 'Canada'
where continent is not null and new_cases <> 0
Group by date
order by 1,2

-- LOOKING AT TOTAL POPULATION VS VACCINATION

Select * 
from Covid_vaccinations

-- Partition by
Select death.continent, death.location, death.date, death.population, vacci.new_vaccinations,
sum(convert(bigint, vacci.new_vaccinations)) 
over (Partition by death.location order by death.location, death.date) as Rolling_people_vaccinated
from Covid_deaths as death 
join Covid_vaccinations as vacci
on death.location = vacci.location
and death.date = vacci.date
where death.continent is not null
order by 2,3

-- We can use two methods CTE and Temp table.
-- Use CTE
with pop_vs_Vac (Continent, Location, Date, Population, New_vaccinations, Rolling_people_vaccinated)
as
(Select death.continent, death.location, death.date, death.population, vacci.new_vaccinations,
sum(convert(bigint, vacci.new_vaccinations)) 
over (Partition by death.location order by death.location, death.date) as Rolling_people_vaccinated
from Covid_deaths as death 
join Covid_vaccinations as vacci
on death.location = vacci.location
and death.date = vacci.date
where death.continent is not null
--order by 2,3
)
Select *, (convert(float,Rolling_people_vaccinated)/Population)*100 as percent_people_vaccinated
from pop_vs_vac

-- Temp Table
Drop table if exists #Percent_people_vaccinated
Create table #Percent_people_vaccinated
(
continent varchar(250), 
location varchar (250),
date date,
population bigint,
new_vaccinations bigint,
Rolling_people_vaccinated bigint)

Insert into #Percent_people_vaccinated
Select death.continent, death.location, death.date, death.population, vacci.new_vaccinations,
sum(convert(bigint, vacci.new_vaccinations)) 
over (Partition by death.location order by death.location, death.date) as Rolling_people_vaccinated
from Covid_deaths as death 
join Covid_vaccinations as vacci
on death.location = vacci.location
and death.date = vacci.date
--where death.continent is not null
--order by 2,3


Select *, (convert(float,Rolling_people_vaccinated)/Population)*100 as percent_population_vaccinated
from #Percent_people_vaccinated


-- Creating view to store data for later visualizations

Create view Percent_population_vaccinated as 
Select death.continent, death.location, death.date, death.population, vacci.new_vaccinations,
sum(convert(bigint, vacci.new_vaccinations)) 
over (Partition by death.location order by death.location, death.date) as Rolling_people_vaccinated
from Covid_deaths as death 
join Covid_vaccinations as vacci
on death.location = vacci.location
and death.date = vacci.date
where death.continent is not null
--order by 2,3

select * 
from Percent_population_vaccinated