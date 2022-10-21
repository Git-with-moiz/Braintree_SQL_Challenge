/* Creating a new table by joining all 4 tables by using with cte*/

CREATE TABLE gdp_unite AS
with cte1 as -- Joining all 4 tables
(
select
contm.continent_code,cont.continent_name,countr.country_code,countr.country_name,per_cap.year,per_cap.gdp_per_capita
from continent_map contm
left outer join continents cont
on contm.continent_code=cont.continent_code
left outer join countries countr
on contm.country_code=countr.country_code
left outer join per_capita per_cap
on countr.country_code=per_cap.country_code
)

SELECT *
FROM CTE1;

select *
from gdp_unite;