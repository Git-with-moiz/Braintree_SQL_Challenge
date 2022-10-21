

/*1:Data Integrity Checking & Cleanup

a:Alphabetically list all of the country codes in the continent_map table that appear more than once. Display any values where country_code is null as country_code = "FOO" and make this row appear first in the list, even though it should alphabetically sort to the middle. Provide the results of this query as your answer.
b:For all countries that have multiple rows in the continent_map table, delete all multiple records leaving only the 1 record per country. The record that you keep should be the first one when sorted by the continent_code alphabetically ascending. Provide the query/ies and explanation of step(s) that you follow to delete these records.
*/

-- PART 1a:
SET SQL_SAFE_UPDATES = 0;

/* Replace '' empty strings with NULL*/
USE braintree;
UPDATE continent_map
    
SET
    country_code = CASE country_code WHEN '' THEN NULL ELSE country_code END,
    continent_code = CASE continent_code WHEN '' THEN NULL ELSE continent_code END;

SET SQL_SAFE_UPDATES = 1;

-- OR USING --
update continent_map set country_code = null where country_code = '';

update continent_map set continent_code = null where continent_code = '';


/* Select Statement To Pull Up Duplicate Country Codes, FOO on top*/

SELECT  
coalesce(country_code,'FOO')
FROM continent_map
GROUP BY country_code
HAVING count(1)>1
ORDER BY country_code;

-- Part 1b

DROP TEMPORARY TABLE IF EXISTS t1;
CREATE TEMPORARY TABLE t1 
(
 SELECT row_number() over (order by country_code, continent_code asc) as 'ID',country_code
,continent_code
FROM braintree.continent_map
);
  
DROP TEMPORARY TABLE IF EXISTS t2;
CREATE TEMPORARY TABLE t2 
(
SELECT MIN(ID) as ID 
FROM t1 GROUP BY country_code 
);
 
/*Delete the rows that dont have a min ID number after group by country_code*/
DELETE FROM t1 WHERE ID NOT IN(select ID from t2) ;

/*Reset continent_map table*/
DELETE FROM continent_map;

/*Refill continent_map from temp_table*/
INSERT INTO continent_map
SELECT country_code, continent_code FROM t1;
 
 /*drop temporary tables*/
 DROP TEMPORARY TABLE t1;
 DROP TEMPORARY TABLE t2;
 
 /*Check result table*/
 SELECT *
 FROM continent_map;