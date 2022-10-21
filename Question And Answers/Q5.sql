/*Q5 Find the sum of gpd_per_capita by year and the count of countries for each year that have non-null gdp_per_capita where (i) the year is before 2012 and (ii) the country has a null gdp_per_capita in 2012. Your result should have the columns:

year
country_count
total
/*

select count(distinct(country_name)) as country_count ,year,sum(gdp_per_capita) as total
from gdp_unite
where gdp_per_capita IS NOT NULL
group by (2)
having year < 2012
order by year ;