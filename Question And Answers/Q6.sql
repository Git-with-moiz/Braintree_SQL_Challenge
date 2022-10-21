/*Q6. All in a single query, execute all of the steps below and provide the results as your final answer:

a. create a single list of all per_capita records for year 2009 that includes columns:

continent_name
country_code
country_name
gdp_per_capita
b. order this list by:

continent_name ascending
characters 2 through 4 (inclusive) of the country_name descending
c. create a running total of gdp_per_capita by continent_name

d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:

continent_name
country_code
country_name
gdp_per_capita
running_total
*/

ALTER TABLE `gdp_unite` ADD `id` INT primary key NOT NULL AUTO_INCREMENT;
with cte1 as
(
select id,country_code,country_name,year,continent_name,gdp_per_capita
from gdp_unite
where year=2009
order by continent_name asc,substring(country_name,2,4)desc
),

cte2 as
(
select *,sum(gdp_per_capita) over (partition by continent_name order by id,continent_name) as cum_sum
from cte1
)

select *
from cte2;