 


select*
from [portfolio project]..[covid vaccination]
where continent is not null
order by 3,4 

select *
From [portfolio project]..[covid dara test]
where continent is not null
order by 1,2


--Looking at Total Cases vs Total Deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [portfolio project]..[covid dara test]
where location like '%nigeria%'
order by 1,2

--Looking at Total Cases vs Populations
 select location, date, total_cases, population, (total_cases/population)*100 as Percentofpopulationaffected
from [portfolio project]..[covid dara test]
where location like '%nigeria%'
order by 1,2


--Looking at countries with highest infection rate compared to population
 select location, population, max(total_cases) as HghestInfectioncount, max((total_cases/population))*100 as Percentofpopulationinffected
from [portfolio project]..[covid dara test]
--where location like '%states'
group by location, population
order by Percentofpopulationinffected desc

--Showing Countries with Highest Death Count per population
 select location, max(cast(total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
group by location, population
order by totaldeathcount desc

--LET BREAK THINGS INTO CONTINENT

 select continent, max(cast(total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
group by continent
order by totaldeathcount desc


 ---Showing the continent the highest death count per population
 select continent, max(cast(total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
group by continent
order by totaldeathcount desc


---GLOBAL NUMBERS
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
--group by date
order by 1,2

select*
from [portfolio project]..[dbo.covid.vacination]

select*
from [portfolio project]..[covid dara test] dar
join [portfolio project]..[dbo.covid.vacination] vac
on dar.location = vac.location
and dar.date = vac.date



---Looking at Total Population vs Vaccinations
select dar.continent, dar.location, dar.date, dar.population, vac.new_vaccinations
, sum(convert(numeric,vac.new_vaccinations)) over (partition by dar.location order by dar.location,
dar.date) as RollingPeopleVaccinated
from [portfolio project]..[covid dara test] dar
  join [portfolio project]..[dbo.covid.vacination] vac
  on dar.location = vac.location
  and dar.date = vac.date
where dar.continent is not null
order by 2,3




----USING CTE
With Popsvac (continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dar.continent, dar.location, dar.date, dar.population, vac.new_vaccinations
, sum(convert(numeric,vac.new_vaccinations)) over (partition by dar.location order by dar.location,
 dar.date) as RollingPeopleVaccinated
from [portfolio project]..[covid dara test] dar
join [portfolio project]..[dbo.covid.vacination] vac
on dar.location = vac.location
and dar.date = vac.date
where dar.continent is not null
---order by 2,3
)
select*, (RollingPeopleVaccinated/population)*100
from Popsvac



---TEMP TABLE
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dar.continent, dar.location, dar.date, dar.population, vac.new_vaccinations
, sum(convert(numeric,vac.new_vaccinations)) over (partition by dar.location order by dar.location, dar.date) 
 as RollingPeopleVaccinated
from [portfolio project]..[covid dara test] dar
join [portfolio project]..[dbo.covid.vacination] vac
on dar.location = vac.location
and dar.date = vac.date
--where dar.continent is not null
---order by 2,3

select*, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated



----Creating View to store data for later visualization

create view PercentPopulationVaccinated as
select dar.continent, dar.location, dar.date, dar.population, vac.new_vaccinations
, sum(convert(numeric,vac.new_vaccinations)) over (partition by dar.location order by dar.location, dar.date) 
 as RollingPeopleVaccinated
from [portfolio project]..[covid dara test] dar
join [portfolio project]..[dbo.covid.vacination] vac
on dar.location = vac.location
and dar.date = vac.date
where dar.continent is not null
---order by 2,3

create view Totaldeathcount as
select continent, max(cast(total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
group by continent
--order by totaldeathcount desc

create view Deathpercent as
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from [portfolio project]..[covid dara test]
--where location like '%states'
where continent is not null
group by date
--order by 1,2


create view Percentofpopulationinffected as
select location, population, max(total_cases) as HghestInfectioncount, max((total_cases/population))*100 as Percentofpopulationinffected
from [portfolio project]..[covid dara test]
--where location like '%states'
group by location, population
---order by Percentofpopulationinffected desc
