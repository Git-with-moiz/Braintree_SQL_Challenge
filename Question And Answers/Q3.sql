/* Q3 For the year 2012, create a 3 column, 1 row report showing the percent share of gdp_per_capita for the following regions:

(i) Asia, (ii) Europe, (iii) the Rest of the World. Your result should look something like

Asia	Europe	Rest of World
25.0%	25.0%	50.0%


/* Extract for the year 2012*/

SELECT continent_name, sum(gdp_per_capita) FROM braintree.gdp_unite

where year = '2012'

group by continent_name;

-- GDP of Asia in %
SELECT 
    CONCAT(ROUND(((SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012' AND continent_name = 'Asia') / (SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012')) * 100,
                    2),
            '%') AS 'Asia',
            
-- GDP of Europe in %
    CONCAT(ROUND(((SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012'
                                AND continent_name = 'Europe') / (SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012')) * 100,
                    2),
            '%') AS 'Europe',
            
-- GDP Rest of the world i.e NOT IN Europe,ASIA in %
    CONCAT(ROUND(((SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012' AND continent_name != 'Asia'
                                AND continent_name != 'Europe') / (SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            braintree.gdp_unite
                        WHERE
                            year = '2012')) * 100,
                    2),
            '%') AS 'Rest of World';