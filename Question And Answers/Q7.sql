/*Q7. Find the country with the highest average gdp_per_capita for each continent for all years. Now compare your list to the following data set. Please describe any and all mistakes that you can find with the data set below. 
Include any code that you use to help detect these mistakes.
*/

select *
from
(
select continent_name, country_code, country_name, avg(gdp_per_capita) as avg_g
,RANK() over(partition by continent_name order by avg(gdp_per_capita) desc) rn
from gdp_unite
group by 1,2,3
) t1
where rn = 1 and country_code IS NOT NULL;