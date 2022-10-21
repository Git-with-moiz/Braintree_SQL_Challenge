
/* Q4 What is the count of countries and sum of their related gdp_per_capita values for the year 2007 where the string 'an' (case insensitive) appears anywhere in the country name?/*

with cte1 as -- Joining all 4 tables
(
select
contm.continent_code,cont.continent_name,countr.country_name,per_cap.year,per_cap.gdp_per_capita
from continent_map contm
left outer join continents cont
on contm.continent_code=cont.continent_code
left outer join countries countr
on contm.country_code=countr.country_code
left outer join per_capita per_cap
on countr.country_code=per_cap.country_code
),

cte2 as ---count of countries and sum of their related gdp_per_capita in year 2007
(
SELECT 
    COUNT(*), SUM(gdp_per_capita)
FROM
    cte1
WHERE
    year = 2007 AND country_name LIKE '%an%' -- insenstive solution
    )
    
    select *
    from cte2;
    
/*sensitive solution*/
SELECT COUNT(*), SUM(gdp_per_capita)
FROM cte2
WHERE year = 2007 AND country_name LIKE BINARY '%an%';  -- sensitive solution using LIKE BINARY