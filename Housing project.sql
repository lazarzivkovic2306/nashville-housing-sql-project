-- Create and populate a staging table
CREATE TABLE nashville_housing_data_2013_2016_staging
LIKE nashville_housing_data_2013_2016;

INSERT nashville_housing_data_2013_2016_staging
SELECT * 
FROM nashville_housing_data_2013_2016;

SELECT * FROM nashville_housing_data_2013_2016_staging;

-- Remove duplicate records based on key fields
SELECT `Parcel ID`, `Property Address`, `Sale Date`, `Legal Reference`, COUNT(*)
FROM nashville_housing_data_2013_2016_staging
GROUP BY `Parcel ID`, `Property Address`, `Sale Date`, `Legal Reference`
HAVING COUNT(*) > 1;

DELETE n
FROM nashville_housing_data_2013_2016_staging n
JOIN (
    SELECT MAX(`Unnamed: 0`) AS max_id
    FROM nashville_housing_data_2013_2016_staging
    GROUP BY `Parcel ID`, `Property Address`, `Sale Date`, `Legal Reference`
    HAVING COUNT(*) > 1
) d ON n.`Unnamed: 0` = d.max_id;

-- Convert sale date to SQL date format
ALTER TABLE nashville_housing_data_2013_2016_staging
ADD COLUMN sale_date_converted DATE;

UPDATE nashville_housing_data_2013_2016_staging
SET sale_date_converted = STR_TO_DATE(`Sale Date`, '%Y-%m-%d');

-- Fill missing Address and City from property fields
UPDATE nashville_housing_data_2013_2016_staging
SET Address = `Property Address`
WHERE (Address IS NULL OR Address = '');

UPDATE nashville_housing_data_2013_2016_staging
SET City = `Property City`
WHERE (City IS NULL OR City = '');

-- Fill remaining missing fields with 'No Record'
UPDATE nashville_housing_data_2013_2016_staging
SET Address = 'No Record'
WHERE (Address IS NULL OR Address = '');

UPDATE nashville_housing_data_2013_2016_staging
SET City = 'No Record'
WHERE (City IS NULL OR City = '');

-- ANALYSIS QUERIES --

-- Average sale price by city
SELECT city, ROUND(AVG(`Sale Price`), 0) AS avg_price
FROM nashville_housing_data_2013_2016_staging
GROUP BY city
ORDER BY avg_price DESC;

-- Total properties sold per year
SELECT YEAR(sale_date_converted) AS sale_year, COUNT(*) AS total_sales
FROM nashville_housing_data_2013_2016_staging
GROUP BY sale_year
ORDER BY sale_year;

-- Top 10 most expensive properties
SELECT * 
FROM nashville_housing_data_2013_2016_staging
ORDER BY `Sale Price` DESC
LIMIT 10;
