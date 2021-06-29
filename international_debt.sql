-- Table: international_debt
CREATE TABLE international_debt
(
  country_name character varying(50),
  country_code character varying(50),
  indicator_name text,
  indicator_code text,
  debt numeric
);

-- Copy over data from CSV
\copy international_debt FROM 'international_debt.csv' DELIMITER ',' CSV HEADER;

-- View some data from table
SELECT *
FROM international_debt
LIMIT 10;

-- Find total of distinct countries
SELECT 
    COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt;

-- Extract the unique debt indicators
SELECT 
    DISTINCT indicator_code AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;

-- Find out total amount of debt
SELECT 
    ROUND(SUM(debt)/1000000, 2) AS total_debt
FROM international_debt;

-- Find out country owing to the highest debt
SELECT 
    country_name, 
    SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;

-- Determine average amount of debt across indicators
SELECT 
    indicator_code AS debt_indicator,
    indicator_name,
    AVG(debt) AS average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC
LIMIT 10;

-- Find out country with highest amount of principal repayments
SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT 
                  MAX(debt)
              FROM international_debt
              WHERE indicator_code='DT.AMT.DLXF.CD');
			  
-- Find out debt indicator that appears most frequently
SELECT 
    indicator_code,
    COUNT(indicator_code) AS indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC
LIMIT 20;

-- Find out maximum amount of debt that each country has
SELECT 
    country_name, 
    MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;